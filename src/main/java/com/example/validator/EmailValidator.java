package com.example.validator;

import javax.naming.directory.*;
import javax.naming.NamingException;
import java.util.Hashtable;
import java.util.regex.Pattern;

public class EmailValidator {

    private static final String EMAIL_REGEX =
            "^(?i)[a-z0-9!#$%&'*+/=?^_`{|}~-]+" +
            "(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*" +
            "@" +
            "(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+" +
            "[a-z]{2,}$";

    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX, Pattern.CASE_INSENSITIVE);

    public static boolean isValidFormat(String email) {
        if (email == null || email.isBlank()) return false;
        return EMAIL_PATTERN.matcher(email).matches();
    }

    public static boolean hasValidMXRecord(String email) {
        if (!isValidFormat(email)) return false;
        String domain = email.substring(email.indexOf('@') + 1);
        try {
            Hashtable<String, String> env = new Hashtable<>();
            env.put("java.naming.factory.initial", "com.sun.jndi.dns.DnsContextFactory");

            DirContext context = new InitialDirContext(env);
            Attributes attrs = context.getAttributes(domain, new String[]{"MX"});
            Attribute attr = attrs.get("MX");
            return attr != null && attr.size() > 0;
        } catch (NamingException e) {
            return false;
        }
    }

    public static boolean isFullyValidEmail(String email) {
        return isValidFormat(email) && hasValidMXRecord(email);
    }
}
