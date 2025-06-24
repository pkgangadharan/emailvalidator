package com.example.validator;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import static org.junit.jupiter.api.Assertions.*;

public class EmailValidatorParamTest {

    @ParameterizedTest
    @ValueSource(strings = {
        "user@example.com",
        "john.doe@gmail.com",
        "valid.email@sub.domain.org"
    })
    void shouldAcceptValidEmails(String email) {
        assertTrue(EmailValidator.isValidFormat(email));
    }

    @ParameterizedTest
    @ValueSource(strings = {
        "bad..email@example.com",
        "missingatsign.com",
        "user@.com",
        "user@localhost"
    })
    void shouldRejectInvalidEmails(String email) {
        assertFalse(EmailValidator.isValidFormat(email));
    }
}
