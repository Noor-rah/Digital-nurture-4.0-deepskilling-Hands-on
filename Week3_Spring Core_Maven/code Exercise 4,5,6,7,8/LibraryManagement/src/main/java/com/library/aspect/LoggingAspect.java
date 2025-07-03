package com.library.aspect;

public class LoggingAspect {

    public void logBefore() {
        System.out.println("[LOG] Before method execution.");
    }

    public void logAfter() {
        System.out.println("[LOG] After method execution.");
    }
}
