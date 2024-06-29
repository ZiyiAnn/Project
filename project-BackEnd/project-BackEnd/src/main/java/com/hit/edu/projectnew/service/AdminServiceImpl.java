package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.dto.User;
import com.hit.edu.projectnew.mapper.AdministratorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService{
  @Autowired
  private AdministratorMapper administratorMapper;
  @Override
  public boolean isAdmin(String AID) {
    if(administratorMapper.countByAccountId(AID)>0){
      return true;
    }else {
      return false;
    }
  }

  @Override
  public User getAdminByID(String AID) {
    return administratorMapper.getAdminById(AID);
  }

  @Override
  public void updateAdmin(User user) {
    administratorMapper.updateAdmin(user);
  }
}
