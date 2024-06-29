package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.dto.User;

public interface AdminService {
  public boolean isAdmin(String SID);
  public User getAdminByID(String AID);
  public void updateAdmin(User user);
}
