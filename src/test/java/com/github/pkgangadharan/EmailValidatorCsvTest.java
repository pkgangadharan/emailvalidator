package com.github.pkgangadharan;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvFileSource;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class EmailValidatorCsvTest {

    @ParameterizedTest
    @CsvFileSource(resources = "/emails.csv", numLinesToSkip = 1)
    void testEmailsFromCsv(String email, boolean expected) {
        boolean result = EmailValidator.isFullyValidEmail(email);
        assertEquals(expected, result);
    }
}
