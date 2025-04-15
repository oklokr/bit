package com.project.service;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.model.UserDto;
import com.project.repository.AdminMapper;

@Service
public class AdminService {
    //수정필요
    @Autowired
    private AdminMapper adminMapper;

    public int getCount(String searchName) {
        if (searchName == null || searchName.isBlank()) {
            return adminMapper.countAll();
        } else {
            return adminMapper.countByName(searchName);
        }
    }

    public List<UserDto> getUsers(Map<String, Object> map){
        return adminMapper.getUsers(map);
    }

    public int deleteUser(String id){
        adminMapper.modifyBoard(id);
        adminMapper.modifyReply(id);
        return adminMapper.deleteUser(id);
    }

    public int changeMemberType(Map<String, Object> map){
        return adminMapper.changeMemberType(map);
    }

    public int resetPassword(String id){
        return adminMapper.resetPassword(id);
    }
}
