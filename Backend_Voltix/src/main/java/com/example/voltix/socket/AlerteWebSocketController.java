package com.example.voltix.socket;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class AlerteWebSocketController {

    @MessageMapping("/AlerteCreated")
    @SendTo("/topic/new-Alerte")
    public String notifyNewStudent(String message) {
        return message;
    }
}
