package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.pojo.photo;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface PhotoService {
  public void savePhoto(MultipartFile file, Integer CID) throws IOException;
  public photo getPhoto(Integer CID);
}
