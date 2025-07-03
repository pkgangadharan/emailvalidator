package in.ind.pkg.utils;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/email")
public class EmailValidatorController {

    @GetMapping("/validate")
    public ValidationResult validate(@RequestParam String email) {
        boolean validFormat = EmailValidator.isValidFormat(email);
        boolean validMX = EmailValidator.hasValidMXRecord(email);
        boolean fullyValid = validFormat && validMX;

        return new ValidationResult(email, validFormat, validMX, fullyValid);
    }

    public static class ValidationResult {
        public String email;
        public boolean validFormat;
        public boolean validMX;
        public boolean fullyValid;

        public ValidationResult(String email, boolean validFormat, boolean validMX, boolean fullyValid) {
            this.email = email;
            this.validFormat = validFormat;
            this.validMX = validMX;
            this.fullyValid = fullyValid;
        }
    }
}
