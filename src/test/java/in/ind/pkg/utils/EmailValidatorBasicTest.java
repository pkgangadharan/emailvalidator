package in.ind.pkg.utils;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class EmailValidatorBasicTest {

    @Test
    void testValidEmails() {
        assertTrue(EmailValidator.isValidFormat("john.doe@example.com"));
    }

    @Test
    void testInvalidEmails() {
        assertFalse(EmailValidator.isValidFormat("no-at-symbol.com"));
    }

    @Test
    void testMXValidation() {
        assertTrue(EmailValidator.hasValidMXRecord("user@gmail.com"));
    }
}
