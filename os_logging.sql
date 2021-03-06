-- Install rsyslog, enable UDP, start daemon, enable autostart.
-- Author: Maarten Smeets.

CREATE USER logger
    IDENTIFIED BY logger;
/

GRANT CONNECT, DBA, RESOURCE TO logger;
/

BEGIN
    DBMS_JAVA.grant_permission ('LOGGER',
                                'SYS:java.net.SocketPermission',
                                'localhost:0',
                                'listen,resolve');
    DBMS_JAVA.grant_permission ('LOGGER',
                                'SYS:java.net.SocketPermission',
                                '127.0.0.1:514',
                                'connect,resolve');
END;
/

-- Under logger user

CREATE OR REPLACE AND COMPILE JAVA SOURCE NAMED "SysLogger"
    AS import java.io.*;
import java.net.*;

public class Syslog {

	// Priorities.
	public static final int LOG_EMERG = 0; // system is unusable
	public static final int LOG_ALERT = 1; // action must be taken immediately
	public static final int LOG_CRIT = 2; // critical conditions
	public static final int LOG_ERR = 3; // error conditions
	public static final int LOG_WARNING = 4; // warning conditions
	public static final int LOG_NOTICE = 5; // normal but significant condition
	public static final int LOG_INFO = 6; // informational
	public static final int LOG_DEBUG = 7; // debug-level messages
	public static final int LOG_PRIMASK = 0x0007; // mask to extract priority

	// Facilities.
	public static final int LOG_KERN = (0 << 3); // kernel messages
	public static final int LOG_USER = (1 << 3); // random user-level messages
	public static final int LOG_MAIL = (2 << 3); // mail system
	public static final int LOG_DAEMON = (3 << 3); // system daemons
	public static final int LOG_AUTH = (4 << 3); // security/authorization
	public static final int LOG_SYSLOG = (5 << 3); // internal syslogd use
	public static final int LOG_LPR = (6 << 3); // line printer subsystem
	public static final int LOG_NEWS = (7 << 3); // network news subsystem
	public static final int LOG_UUCP = (8 << 3); // UUCP subsystem
	public static final int LOG_CRON = (15 << 3); // clock daemon
	// Other codes through 15 reserved for system use.
	public static final int LOG_LOCAL0 = (16 << 3); // reserved for local use
	public static final int LOG_LOCAL1 = (17 << 3); // reserved for local use
	public static final int LOG_LOCAL2 = (18 << 3); // reserved for local use
	public static final int LOG_LOCAL3 = (19 << 3); // reserved for local use
	public static final int LOG_LOCAL4 = (20 << 3); // reserved for local use
	public static final int LOG_LOCAL5 = (21 << 3); // reserved for local use
	public static final int LOG_LOCAL6 = (22 << 3); // reserved for local use
	public static final int LOG_LOCAL7 = (23 << 3); // reserved for local use

	public static final int LOG_FACMASK = 0x03F8; // mask to extract facility

	// Option flags.
	public static final int LOG_PID = 0x01; // log the pid with each message
	public static final int LOG_CONS = 0x02; // log on the console if errors
	public static final int LOG_NDELAY = 0x08; // don't delay open
	public static final int LOG_NOWAIT = 0x10; // don't wait for console forks

	private static final int DEFAULT_PORT = 514;

	/// Use this method to log your syslog messages. The facility and
	// level are the same as their Unix counterparts, and the Syslog
	// class provides constants for these fields. The msg is what is
	// actually logged.
	// @exception SyslogException if there was a problem
	@SuppressWarnings("deprecation")
	public static String syslog(String hostname, Integer port, String ident, Integer facility, Integer priority, String msg) {
		try {
			InetAddress address;
			if (hostname == null) {
				address = InetAddress.getLocalHost();
			} else {
				address = InetAddress.getByName(hostname);
			}

			if (port == null) {
				port = new Integer(DEFAULT_PORT);
			}
			if (facility == null) {
				facility = 1; // means user-level messages
			}
			if (ident == null)
				ident = new String(Thread.currentThread().getName());

			int pricode;
			int length;
			int idx;
			byte[] data;
			String strObj;

			pricode = MakePriorityCode(facility, priority);
			Integer priObj = new Integer(pricode);

			length = 4 + ident.length() + msg.length() + 1;
			length += (pricode > 99) ? 3 : ((pricode > 9) ? 2 : 1);

			data = new byte[length];

			idx = 0;
			data[idx++] = '<';

			strObj = Integer.toString(priObj.intValue());
			strObj.getBytes(0, strObj.length(), data, idx);
			idx += strObj.length();

			data[idx++] = '>';

			ident.getBytes(0, ident.length(), data, idx);
			idx += ident.length();

			data[idx++] = ':';
			data[idx++] = ' ';

			msg.getBytes(0, msg.length(), data, idx);
			idx += msg.length();

			data[idx] = 0;

			DatagramPacket packet = new DatagramPacket(data, length, address, port);
			DatagramSocket socket = new DatagramSocket();
			socket.send(packet);
			socket.close();
		} catch (IOException e) {
			return "error sending message: '" + e.getMessage() + "'";
		}
		return "";
	}

	private static int MakePriorityCode(int facility, int priority) {
		return ((facility & LOG_FACMASK) | priority);
	}
}
/

CREATE OR REPLACE PROCEDURE SYSLOGGER (p_hostname   IN VARCHAR2,
                                       p_port       IN NUMBER,
                                       p_ident      IN VARCHAR2,
                                       p_facility   IN NUMBER,
                                       p_priority   IN NUMBER,
                                       p_msg        IN VARCHAR2)
AS
    LANGUAGE JAVA
    NAME 'Syslog.syslog(java.lang.String,java.lang.Integer,java.lang.String,java.lang.Integer,java.lang.Integer,java.lang.String)' ;

-- Test

DECLARE
    P_HOSTNAME   VARCHAR2 (200);
    P_PORT       NUMBER;
    P_IDENT      VARCHAR2 (200);
    P_FACILITY   NUMBER;
    P_PRIORITY   NUMBER;
    P_MSG        VARCHAR2 (200);
BEGIN
    P_HOSTNAME := NULL;
    P_PORT := NULL;
    P_IDENT := 'Syslogtest';
    P_FACILITY := NULL;
    P_PRIORITY := 1;
    P_MSG := 'Hi there';

    SYSLOGGER (P_HOSTNAME   => P_HOSTNAME,
               P_PORT       => P_PORT,
               P_IDENT      => P_IDENT,
               P_FACILITY   => P_FACILITY,
               P_PRIORITY   => P_PRIORITY,
               P_MSG        => P_MSG);
END;