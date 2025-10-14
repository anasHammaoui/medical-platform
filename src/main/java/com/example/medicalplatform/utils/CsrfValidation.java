package com.example.medicalplatform.utils;

import java.util.UUID;

public class CsrfValidation {
    public static String generateCsrfToken(){
        return UUID.randomUUID().toString();
    }
    public static boolean validateToken(String token, String sessionToken){
        return token != null && token.equals(sessionToken);
    }
}
