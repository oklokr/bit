package com.project.repository;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

import com.project.model.BoardDto;
import com.project.model.ReplyDto;

@Mapper
public interface BoardMapper {
    public int getCount();
    public List<BoardDto> getArticles(Map<String, Integer> map);
    public BoardDto getArticle(int board_id);
    public void addCount(int board_id);
    public int insertPost(BoardDto boardDto);
    public int modifyPost(BoardDto boardDto);
    public int deletePost(int board_id);
    public int getReplyCount(int board_id);
    public List<ReplyDto> getReplies(int board_id);
    public int insertReply(ReplyDto replyDto);
}