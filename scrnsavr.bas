DECLARE SUB squr (calltime!)
DECLARE SUB lne (calltime)
DECLARE SUB pie (calltime)
DECLARE FUNCTION calcspeed! ()
DECLARE SUB UpAAndDown (UpAndDown, down$)
DECLARE SUB presetterr (presetter, presetter$, clr, minus$)
RANDOMIZE TIMER
CLS
DIM SHARED s, cont
lastaction = TIMER
TYPE points
  x AS LONG
  y AS LONG
END TYPE
TYPE eraselag
  x AS LONG
  y AS LONG
  rotate AS LONG
END TYPE

DO
  SCREEN 0
  COLOR 0, 0
  CLS
  COLOR 15, 1
  PRINT SPACE$(20); "MONTAGE SCREEN SAVER made in QBASIC 1.0"; SPACE$(20)
  LOCATE 8, 32
  PRINT "Wait 2 seconds or"
  LOCATE , 32
  PRINT "push 3 to activate"
  LOCATE , 32
  PRINT "Screensaver"
  LOCATE , 32
  PRINT " <ESC> to Exit  "

  PRINT ""
  DO
    IF TIMER - lastaction >= 5 THEN
      k = INT(RND * 3) + 1
      k$ = LTRIM$(RTRIM$(STR$(k)))
      lastaction = 0
      calltime = TIMER
      EXIT DO
    END IF
    k$ = INKEY$
  LOOP UNTIL k$ <> ""
  IF lastaction <> 0 THEN
    calltime = 0
  END IF
  SELECT CASE UCASE$(LEFT$(k$, 1))
    CASE "1"
      CALL pie(calltime)
    CASE "2"
      CALL lne(calltime)
    CASE "3"
      CALL squr(calltime)
    CASE CHR$(27)
      SYSTEM
  END SELECT
  lastaction = TIMER
LOOP
END

FUNCTION calcspeed
  i = 0
  start = TIMER
  DO: i = i + 1: LOOP WHILE TIMER < start + .3
  calcspeed = i
END FUNCTION

SUB lne (calltime)
  CLS
  SCREEN 12
  CONST FALSE = -0, TRUE = NOT FALSE
  DIM p(1, 2) AS points
  DIM way(1) AS points
  p(0, 0).x = RND * 638 + 1
  p(1, 0).x = RND * 638 + 1
  p(0, 0).y = RND * 478 + 1
  p(1, 0).y = RND * 478 + 1

  p(0, 1).x = p(0, 0).x + 15
  p(1, 1).x = p(1, 0).x + 15
  p(0, 1).y = p(0, 0).y + 15
  p(1, 1).y = p(1, 0).y + 15

  p(0, 2).x = p(0, 1).x + 15
  p(1, 2).x = p(1, 1).x + 15
  p(0, 2).y = p(0, 1).y + 15
  p(1, 2).y = p(1, 1).y + 15

  way(0).x = RND * 5
  way(1).x = RND * 5
  way(0).y = RND * 5
  way(1).y = RND * 5
  delay = calcspeed
  DO
    LINE (p(0, 0).x, p(0, 0).y)-(p(1, 0).x, p(1, 0).y), 0
    LINE (p(0, 1).x, p(0, 1).y)-(p(1, 1).x, p(1, 1).y), 0
    LINE (p(0, 2).x, p(0, 2).y)-(p(1, 2).x, p(1, 2).y), 0
    FOR j = 0 TO 2
      FOR i = 0 TO 1
        p(i, j).x = p(i, j).x + way(i).x
        p(i, j).y = p(i, j).y + way(i).y
        IF p(i, j).x >= 640 THEN
          way(i).x = -way(i).x
          p(i, j).x = 640
        ELSEIF p(i, j).x <= 0 THEN
          way(i).x = -way(i).x
          p(i, j).x = 0
        END IF
        IF p(i, j).y >= 480 THEN
          way(i).y = -way(i).y
          p(i, j).y = 480
        ELSEIF p(i, j).y <= 0 THEN
          way(i).y = -way(i).y
          p(i, j).y = 0
        END IF
        IF way(i).x = 0 THEN way(i).x = RND * 5
        IF way(i).y = 0 THEN way(i).y = RND * 5
      NEXT i
    NEXT j
    LINE (p(0, 0).x, p(0, 0).y)-(p(1, 0).x, p(1, 0).y), 1
    LINE (p(0, 1).x, p(0, 1).y)-(p(1, 1).x, p(1, 1).y), 2
    LINE (p(0, 2).x, p(0, 2).y)-(p(1, 2).x, p(1, 2).y), 5
    FOR z = 1 TO delay: NEXT z
    IF calltime <> 0 AND TIMER - calltime >= 15 THEN
      EXIT DO
    END IF
  LOOP UNTIL INKEY$ <> ""
  CLS
END SUB

SUB pie (calltime)
  CLS
  SCREEN 12
  maxbox = 0
  DIM behind(maxbox) AS eraselag
  CONST TRUE = 1, FALSE = -0
  VIEW PRINT 1 TO 30
  s = 4
  s$ = "S" + STR$(s)
  cont = 0
  do$ = "no"
  count = 0
  presetter = RND * 640
  presetter$ = ""
  clr = 1
  UpAndDown = RND * 350
  minus$ = "YES"
  doo = 1
  delay = calcspeed
  drew1$ = "BL10 D25 L10 D10 R30 U10 L10 U50 R10 U10 L30 D10 R10 D25"
  drew2$ = ""
  drew3$ = "BR80 BU20 D70 R30 U14 L20 U14 R15 U14 L15 U14 R20 U14 L30"
  figure$ = drew1$ + drew2$ + drew3$
  DO
   
    FOR move = 0 TO maxbox - 1
      behind(move).x = behind(move + 1).x
      behind(move).y = behind(move + 1).y
      behind(move).rotate = behind(move + 1).rotate
    NEXT move
   
    FOR d = 1 TO delay: NEXT d
   
    IF doo = 1 THEN
      finaldrw1$ = "C0" + "TA" + STR$(behind(0).rotate) + figure$
      PSET (behind(0).x, behind(0).y), 0
      DRAW finaldrw1$
    END IF
   
    CALL UpAAndDown(UpAndDown, down$)
    CALL presetterr(presetter, presetter$, clr, minus$)
    IF minus$ = "YES" THEN
      count = count - 5
    END IF
    IF minus$ = "NO" THEN
      count = count + 5
    END IF
    IF clr = 16 THEN
      clr = 1
    END IF
    IF count = -360 THEN
      count = 0
    END IF
    IF count = 360 THEN
      count = 0
    END IF
  
    behind(maxbox).x = presetter
    behind(maxbox).y = UpAndDown
    behind(maxbox).rotate = count

    drw$ = "TA"
    drw1$ = STR$(count)
    finaldrw$ = drw$ + drw1$ + figure$
    PSET (presetter, UpAndDown), clr
    DRAW finaldrw$
    IF calltime <> 0 AND TIMER - calltime >= 15 THEN
      EXIT DO
    END IF
  LOOP UNTIL INKEY$ <> ""
  CLS
END SUB

SUB presetterr (presetter, presetter$, clr, minus$)
  IF presetter > 640 THEN
    presetter$ = "down"
    clr = clr + 2
  END IF
  IF presetter < 0 THEN
    presetter$ = ""
    clr = clr - 1
  END IF
  IF presetter$ = "down" THEN
    presetter = presetter - 5
    minus$ = "NO"
  END IF
  IF presetter$ = "" THEN
    presetter = presetter + 5
    minus$ = "YES"
  END IF
END SUB

SUB squr (calltime)
  CLS
  SCREEN 12
  maxbox = 40
  DIM behind(maxbox) AS eraselag
  CONST TRUE = 1, FALSE = -0
  VIEW PRINT 1 TO 30
  s = 4
  s$ = "S" + STR$(s)
  cont = 0
  do$ = "no"
  count = 0
  presetter = RND * 640
  presetter$ = ""
  clr = 1
  UpAndDown = RND * 350
  minus$ = "YES"
  doo = 1
  delay = calcspeed
  DO
    FOR move = 1 TO maxbox - 1
      behind(move).x = behind(move + 1).x
      behind(move).y = behind(move + 1).y
      behind(move).rotate = behind(move + 1).rotate
    NEXT move
    FOR d = 1 TO delay: NEXT d
    IF doo = 1 THEN
      finaldrw1$ = "C0" + "TA" + STR$(behind(1).rotate) + "BU25 R25 D50 L50 U50 R25"
      PSET (behind(1).x, behind(1).y), 0
      DRAW finaldrw1$
    END IF
    CALL UpAAndDown(UpAndDown, down$)
    CALL presetterr(presetter, presetter$, clr, minus$)
    IF minus$ = "YES" THEN
      count = count - 5
    END IF
    IF minus$ = "NO" THEN
      count = count + 5
    END IF
    IF clr = 16 THEN
      clr = 1
    END IF
    IF count = -360 THEN
      count = 0
    END IF
    IF count = 360 THEN
      count = 0
    END IF
    behind(maxbox).x = presetter
    behind(maxbox).y = UpAndDown
    behind(maxbox).rotate = count
    drw$ = "TA"
    drw1$ = STR$(count)
    draw$ = drw$ + drw1$ + "C" + STR$(clr) + "BU25 R25 D50 L50 U50 R25"
    finaldrw$ = draw$
    PSET (presetter, UpAndDown), 0
    DRAW finaldrw$
    IF calltime <> 0 AND TIMER - calltime >= 15 THEN
      EXIT DO
    END IF
  LOOP UNTIL INKEY$ <> ""
  COLOR 0
  CLS

END SUB

SUB UpAAndDown (UpAndDown, down$)
  IF UpAndDown > 480 THEN
    down$ = "yes"
  END IF
  IF UpAndDown < 0 THEN
    down$ = "no"
  END IF
  IF down$ = "yes" THEN
    UpAndDown = UpAndDown - 5
  ELSE
    UpAndDown = UpAndDown + 5
  END IF
END SUB

