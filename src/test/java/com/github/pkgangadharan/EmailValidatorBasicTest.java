package com.github.pkgangadharan;

import com.github.pkgangadharan.EmailValidator;
import org.junit.jupiter.api.Test;

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
