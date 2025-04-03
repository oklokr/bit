<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="editor">
    <h2>Demo Content</h2>
    <p>Preset build with <code>snow</code> theme, and some common formats.</p>
</div>
    
<script>
const quill = new Quill('#editor', {
    theme: 'snow'     // 해당 부분을 변경하면 됨 
});
</script>