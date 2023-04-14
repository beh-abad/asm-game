.model small
.stack 8;Yek poshte 8 byte.
.data

      message0 db 30, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196, 196,196, 196, 196, 31, "$";In qesmat baray chracter haye _ ast
      message1 db 10, 'Simple Game', "$"
      message2 db 10, '1.Shoro bazi', "$"     
      message3 db 10, '2.Khorooj', "$" 
      message4 db 10, 'Lotfan yek shomare ra vared konid:', "$"      
      message5 db 10, 7, 'Harkat: a, w, s, d', "$" 
      message6 db 10, 'Oboor az khate sabz: Barande', "$"
      message7 db 10, 'Oboor az khate qermez: Bazandeh', "$" 
      message8 db 10, 'Lotfan hengam load sabr konid... ', "$" 
      message9 db 10, 'Shome barande shodid!',7 ,7, "$"
      message10 db 10, 'Shoma bakhtid!',7 ,7, "$"
      squarePosX dw ?;Baraye zkhire makan avalie moraba roye mehvar X.
      squarePosY dw ?;Baraye zkhire makan avalie moraba roye mehvar Y.
      linePosX dw ?;Baraye zkhire makan avalie khat roye mehvar X.
      linePosY dw ?;Baraye zkhire makan avalie khat roye mehvar Y.
      squareLastPosX dw ?;Baraye zkhire makan akhar moraba roye mehvar X.
      squareLastPosY dw ?;Baraye zkhire makan akhar moraba roye mehvar Y. 
      
.code 

    Main proc far      
      
      push 0
      SQURE_SIZE equ 4  
      mov ax, @data;Zaqire address segment dadeh dar sabat ax.
      mov ds, ax;Zaqire address dar data segment. 
      mov dl, 32;Moqiat makan cursur
      mov dh, 3;Moqiat makan cursur
      call SetCursorPosition
      lea  dx, message0
      call PrintStrings;Neveshtan string dar an makan.
      mov dl, 35
      mov dh, 4
      call SetCursorPosition
      lea  dx, message1
      call PrintStrings
      mov dl, 32
      mov dh, 7
      call SetCursorPosition
      lea  dx, message0
      call PrintStrings
      mov dl, 34
      mov dh, 10
      call SetCursorPosition
      lea  dx, message2
      call PrintStrings
      mov dl, 35
      mov dh, 12
      call SetCursorPosition
      lea  dx, message3
      call PrintStrings
      mov dl, 23
      mov dh, 15
      call SetCursorPosition
      lea  dx, message4
      call PrintStrings      
      call GetAnswer
      mov dl, 1
      mov dh, 1
      call SetCursorPosition
      lea  dx, message5
      call PrintStrings       
      mov dl, 1
      mov dh, 5
      call SetCursorPosition
      lea  dx, message6
      call PrintStrings
      mov dl, 1
      mov dh, 9
      call SetCursorPosition
      lea  dx, message7
      call PrintStrings      
      mov dl, 1
      mov dh, 13 
      call SetCursorPosition
      lea  dx, message8
      call PrintStrings     
      mov al, 0xc;Range pixel haye khat.
      mov cx, 200;Makan X Pixel.
      mov dx, 200;Makan Y pixel.          
      call DrawALine 
      mov al, 0xa
      mov cx, 420
      mov dx, 200
      call DrawALine
      mov al, 0xb
      mov cx, 310
      mov dx, 200    
      
      back:
      
      mov al, 0x0b
      call DrawASquare
      call CheckSquareStatus      
      mov ah, 0x0
      int 0x16;In qesmat yek character az vorodi migirad
      cmp ah, 0x20;Agar character d bood...
      jz moveRight;Bepar be label moveRight.
      cmp ah, 0x11;Agar character w bood...
      jz moveUp;Bepar be label moveUp.
      cmp ah, 0x1e;Agar character a bood...
      jz moveLeft;Bepar be label moveLeft.
      cmp ah, 0x1f;Agar character s bood...
      jz moveDown;Bepar be label moveDown.
      jmp back:;agar hijkodoom nabood bargard be back.
      
      moveRight:
      
     ; mov al, 0x00 //Agar mikhahid moraba az makan qabli pak shavad in qesmat ra az comment dar biavarid. 
     ; call DrawASquare//Agar mikhahid moraba az makan qabli pak shavad in qesmat ra az comment dar biavarid.
      add cx, 15;In qesmat moraba ra 15 pixel be rast mibarad.  
      jmp back
      
      moveUp:
      
     ; mov al, 0x00//Agar mikhahid moraba az makan qabli pak shavad in qesmat ra az comment dar biavarid.
     ; call DrawASquare//Agar mikhahid moraba az makan qabli pak shavad in qesmat ra az comment dar biavarid.
      sub dx, 15;In qesmat moraba ra 15 pixel be bala mibarad.   
      jmp back
      
      moveLeft:
      
     ; mov al, 0x00//Agar mikhahid moraba az makan qabli pak shavad in qesmat ra az comment dar biavarid.
     ; call DrawASquare//Agar mikhahid moraba az makan qabli pak shavad in qesmat ra az comment dar biavarid.
      sub cx, 15;In qesmat moraba ra 15 pixel be chap mibarad.     
      jmp back
      
      moveDown:       
      
     ; mov al, 0x00//Agar mikhahid moraba az makan qabli pak shavad in qesmat ra az comment dar biavarid.
     ; call DrawASquare//Agar mikhahid moraba az makan qabli pak shavad in qesmat ra az comment dar biavarid.         
      add dx, 15;In qesmat moraba ra 15 pixel be payin mibarad. 
      jmp back         
               
      ret 0
     
    Main endp
    
;In tabe baraye enteqal curser ast.

    SetCursorPosition proc near
     
      mov ah, 0x2
      mov bh, 0
      int 10h
      ret
       
    SetCursorPosition endp
    
;In tabe baraye chape etelaat ast.

    PrintStrings proc near
        
      mov ah, 0x9
      int 0x21
      ret 
        
    PrintStrings endp
    
;In tabe baraye greftane javab entekhab az karbar va taqire mode video ast.

    GetAnswer proc near
        
      askAgain:
       
      mov ah, 0x0
      int 0x16
      cmp ah, 0x3
      jz answer2
      cmp ah, 0x2
      jz answer1      
      jmp askAgain
              
      answer1:
       
        mov ah, 0x0
        mov al, 0x12
        int 0x10
        ret               
                          
      answer2:
       
        mov ah, 0x00
        int 0x21                   
        
   GetAnswer endp    

;In tabe baraye tarahi moraba ast.
 
   DrawASquare proc near
    
      lea bx, squarePosX;Makan avalie ra zakhire kon.
      mov [bx], cx
      lea bx, squarePosY
      mov [bx], dx      
      mov ah, 0x0c 
      mov di, 0
       
      for0:
       
      add di, 2
      cmp di, SQURE_SIZE    
      jnbe endFor0
                
         mov si, 0
          
         for1:
          
         cmp si, SQURE_SIZE
         jz endFor1
                        
            int 0x10
            inc cx
            inc si
            jmp for1
                              
         endFor1:
         inc dx
         mov si, 0 
                    
         for2:
                     
         cmp si, SQURE_SIZE
         jz endFor2
          
            dec cx
            inc si
            int 0x10
            jmp for2
             
         endFor2: 
          
         inc dx            
         jmp for0        
          
      endFor0:     
            
      mov squareLastPosX, cx           
      mov squareLastPosY, dx
      mov cx, squarePosX
      mov dx, squarePosY          
      ret
                
    
  DrawAsquare endp   
   
;In tabe baraye tarahi khat ast.

  DrawALine proc near
    
      lea bx, linePosX
      mov [bx], cx
      lea bx, linePosY
      mov [bx], dx
      mov ah, 0x0c
      mov di, 0
       
      for3:
       
      cmp di, 2;Tedad sotoone khat.
      jz endFor3
                
         mov si, 0
          
         for4:
          
         cmp si, 40;Tedad setre khat.
         jz endFor4
                        
            int 0x10
            inc dx
            inc si
            jmp for4
             
         endFor4:
          
         inc di
         inc cx
         mov si, 0 
                    
         for5:
                     
         cmp si, 40;...
         jz endFor5
          
            dec dx
            inc si
            int 0x10
            jmp for5
             
         endFor5:   
          
         inc di            
         jmp for3
          
      endFor3:     
      
      ret
    
  DrawALine endp
   
;In tabe baraye barresi vaziyiat moraba ast.

  CheckSquareStatus proc near
         
      cmp cx, 420;Agar makan morabe az 420 bishtar shod...
      jnbe winner;Bepar be label winner. 
      cmp cx, 200;...
      jna loser;...
      ret
        
        winner:;Agar karabar barade shode safhe jadid baz kon va payam barade ra chap kon.
        
        mov ah, 0x0
        mov al, 0x12
        int 0x10
        mov dl, 29
        mov dh, 25
        call SetCursorPosition
        lea dx, message9 
        call PrintStrings
        ret
        
        loser:;...
        
        mov ah, 0x0
        mov al, 0x12
        int 0x10
        mov dl, 33
        mov dh, 25
        call SetCursorPosition
        lea dx, message10 
        call PrintStrings
        ret
          
  CheckSquareStatus endp
            
end Main        