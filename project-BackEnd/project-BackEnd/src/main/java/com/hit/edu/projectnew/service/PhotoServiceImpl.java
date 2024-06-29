package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.mapper.PhotoMapper;
import com.hit.edu.projectnew.pojo.photo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.relational.core.sql.In;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public class PhotoServiceImpl implements PhotoService{
  @Autowired
  private PhotoMapper photoMapper;

  public void savePhoto(MultipartFile file, Integer CID) throws IOException {
    photo photo = new photo();
    photo.setCID(CID);
    photo.setFileName(file.getOriginalFilename());
    photo.setPhotoData(file.getBytes());
    photoMapper.savePhoto(photo);
  }

  public photo getPhoto(Integer CID) {
    return photoMapper.getPhotoById(CID);
  }
}
