
##添加文件夹
1. 最上增加  
2. 工程后增加 

如下:

    set_property(GLOBAL PROPERTY USE_FOLDERS ON) # step 1  
    ADD_EXECUTABLE (${TARGET_NAME} ${HEADERS_LIST} ${SRC_LIST})  
    SET_TARGET_PROPERTIES(${TARGET_NAME} PROPERTIES FOLDER "Applications") #step 2  
    
*******
