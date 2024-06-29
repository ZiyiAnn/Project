package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.mapper.MessageMapper;
import com.hit.edu.projectnew.pojo.message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService{

  @Autowired
  private MessageMapper messageMapper;
  @Override
  public void addMessage(message message) throws Exception {
    if (message.getContent().length() > 255) {
      throw new Exception("Content cannot exceed 255 characters");
    }else{
      messageMapper.addMessage(message);
    }
  }

  @Override
  public void updateMessageStatus(Integer ID) {
    messageMapper.updateMessage(ID);
  }

  @Override
  public List<message> getAllMessage() {
    return messageMapper.getAllMessage();
  }

  @Override
  public List<message> getYesMessage() {
    return messageMapper.getYesMessage();
  }

  @Override
  public List<message> getNoMessage() {
    return messageMapper.getNoMessage();
  }
}
