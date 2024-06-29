package com.hit.edu.projectnew;

import com.hit.edu.projectnew.mapper.ClassroomMapper;
import com.hit.edu.projectnew.pojo.classroom;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class ProjectNewApplicationTests {
    @Autowired
    private ClassroomMapper classroomMapper;
//    @Test
//    public void testListClassroom(){
//        List<classroom> classroomList = classroomMapper.list();
//        classroomList.stream().forEach(classroom -> {
//            System.out.println(classroom);
//        });
//
//    }
}
