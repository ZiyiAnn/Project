package com.hit.edu.projectnew.controller;

import com.hit.edu.projectnew.pojo.announcement;
import com.hit.edu.projectnew.pojo.classroom;
import com.hit.edu.projectnew.service.AnnouncementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class AnnouncementController {
  @Autowired
  private AnnouncementService announcementService;
  @GetMapping("/getAllAnno")
  List<announcement> getAllAnno(){
    return announcementService.getAllAnno();
  }
  @RequestMapping("/AddAnno")
  @PostMapping
  public Map<String, Object> addAnnouncement(@RequestBody Map<String, String> annoInfo) {
    Map<String, Object> response = new HashMap<>();
    String  annoContent = annoInfo.get("annoContent");
    try {
      announcementService.addAnno(annoContent);
      response.put("success", true);
      response.put("message", "Announcement added successfully");
    } catch (Exception e) {
      response.put("success", false);
      response.put("message", e.getMessage());
    }
    return response;
  }

  @DeleteMapping("/DeleteAnno/{ID}")
  public Map<String, Object> deleteAnnouncement(@PathVariable int ID) {
    Map<String, Object> response = new HashMap<>();
    try {
      announcementService.deleteAnno(ID);
      response.put("success", true);
      response.put("message", "Announcement deleted successfully");
      response.put("ID", ID); // 返回被删除的教室的CID
    } catch (Exception e) {
      response.put("success", false);
      response.put("message", e.getMessage());
    }
    return response;
  }

}
