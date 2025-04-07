package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.model.BoardDto;
import com.project.model.ReplyDto;
import com.project.repository.BoardMapper;

@Service
public class BoardService {
    @Autowired
    private BoardMapper boardmapper;

    public int getCount(){
        return boardmapper.getCount();
    }

    public List<BoardDto> getArticles(Map<String, Integer> map){
        return boardmapper.getArticles(map);
    }

    public BoardDto getArticle(int boardId){
        return boardmapper.getArticle(boardId);
    }

    public void addCount(int boardId){
        boardmapper.addCount(boardId);
    }

    public int insertPost(BoardDto boardDto){
        return boardmapper.insertPost(boardDto);
    }

    public int modifyPost(BoardDto boardDto){
        return boardmapper.modifyPost(boardDto);
    }

    public int deletePost(int boardId){
        return boardmapper.deletePost(boardId);
    }

    public int getReplyCount(int boardId){
        return boardmapper.getReplyCount(boardId);
    }

    public List<ReplyDto> getReplies(int boardId){
        return boardmapper.getReplies(boardId);
    }

    public int insertReply(ReplyDto replyDto){
        if (replyDto.getReplyLevel() == 0) {
            int maxRef = boardmapper.getMaxReplyRef(replyDto.getBoardId());
            replyDto.setReplyRef(maxRef + 1);
            replyDto.setReplyStep(0);
        } else if (replyDto.getReplyLevel() == 1) {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("boardId", replyDto.getBoardId());
            paramMap.put("replyRef", replyDto.getReplyRef());

            int maxStep = boardmapper.getMaxReplyStep(paramMap);
            replyDto.setReplyStep(maxStep + 1);
        }
       return boardmapper.insertReply(replyDto);
    }

}
