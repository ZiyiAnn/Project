package com.hit.edu.projectnew.controller;

import com.hit.edu.projectnew.pojo.message;
import com.hit.edu.projectnew.pojo.reservation;
import com.hit.edu.projectnew.service.MessageService;
import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class MessageController {
  @Autowired
  private MessageService messageService;
  @PostMapping("/addMessage")
  public Map<String, Object> addMessage(@RequestBody Map<String, String> messageInfo){
    Map<String, Object> response = new HashMap<>();
    String content = messageInfo.get("content");
    String sender = messageInfo.get("sender");
    LocalDateTime dateTime = LocalDateTime.now();

    message message = new message();
    message.setContent(content);
    message.setSender(sender);
    message.setReceiver("repair");
    message.setDateTime(dateTime);
    message.setStatus(0);

    try {
      messageService.addMessage(message);
      response.put("success", true);
      response.put("message","Add message Successfully!");
    }catch (Exception e){
      response.put("success", false);
      response.put("message", e.getMessage());
    }
    return response;
  }

  @GetMapping("/updateMessageStatus")
  public Map<String, Object> deleteMessage(@RequestParam Integer ID){
    Map<String, Object> response = new HashMap<>();
    try{
      messageService.updateMessageStatus(ID);
      response.put("success", true);
      response.put("message","this message has been read!");
    }catch (Exception e){
      response.put("success", false);
      response.put("message", e.getMessage());
    }
    return response;
  }
  @GetMapping("/getMessageYes")
  public Map<String, Object> getYesMessage() {
    Map<String, Object> response = new HashMap<>();
    try {
      List<message> message= messageService.getYesMessage();
      response.put("success", true);
      response.put("message", message);
    } catch (Exception e) {
      response.put("success", false);
      response.put("message", "Failed to fetch messages: " + e.getMessage());
    }
    return response;
  }
  @GetMapping("/getMessageNo")
  public Map<String, Object> getNoMessage() {
    Map<String, Object> response = new HashMap<>();
    try {
      List<message> message= messageService.getNoMessage();
      response.put("success", true);
      response.put("message", message);
    } catch (Exception e) {
      response.put("success", false);
      response.put("message", "Failed to fetch messages: " + e.getMessage());
    }
    return response;
  }
}
