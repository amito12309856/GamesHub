:: feito em 4 dias. (estou atualizando diariamente)

@echo off
title Games Hub By Xamito e enis7
cls
chcp 65001 >nul
color 4

{
  :VERIFICAR_ATUALIZACAO
  @echo off
  setlocal enabledelayedexpansion
  
  echo Verificando atualizações...
  set "repo_url=https://github.com/amito12309856/GamesHub/raw/main/Games%20hub.bat"
  set "temp_file=%temp%\Games_hub_novo.bat"

  bitsadmin /transfer atualizar /download /priority high "%repo_url%" "%temp_file%" >nul

  if not exist "%temp_file%" (
      echo Erro: Não foi possível baixar a atualização.
      timeout /t 3 >nul
      goto acesso
  )

  fc /b "%~f0" "%temp_file%" >nul
  if %errorlevel% equ 0 (
      echo Seu hub já está na versão mais recente!
      del "%temp_file%" >nul
      timeout /t 2 >nul
      goto acesso
  )

  echo Nova versão encontrada! Atualizando...
  timeout /t 3 >nul

  copy "%~f0" "%~dp0Games hub_backup.bat" >nul

  ren "%~f0" "Games_hub_old.bat" >nul
  move /y "%temp_file%" "Games hub.bat" >nul
  del "Games_hub_old.bat" >nul

  start "" "Games hub.bat"
  goto acesso
}

{
  :acesso
  @echo off
  setlocal
  
  set "logfile=logs\acessos.txt"
  
  if not exist logs (
      mkdir logs
  )
  
  for /f "tokens=1-3 delims= " %%a in ('date /t') do set "data=%%a%%b%%c"
  for /f "tokens=1-2 delims=:" %%a in ('time /t') do set "hora=%%a:%%b"
  
  set "entrada=%data% %hora%"
  
  echo [ACESSO] Data %data% e Hora %hora% >> "%logfile%"
  
  echo Acesso registrado em %logfile%: %entrada%
  
  goto plugins
}

{
  :plugins
  @echo off
  setlocal enabledelayedexpansion

  set "pasta=plugins\estatisticas"
  set "tempo_file=%pasta%\tempo_total.txt"
  set "acessos_file=%pasta%\acessos_dia.txt"

  if not exist "%pasta%" mkdir "%pasta%"
  if not exist "%tempo_file%" echo 0 > "%tempo_file%"
  if not exist "%acessos_file%" echo. > "%acessos_file%"

  for /f %%a in (%tempo_file%) do set /a "novo_tempo=%%a+5"
  echo !novo_tempo! > "%tempo_file%"

  for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set "hoje=%%a-%%b-%%c"
  set "encontrado=0"
  
  (for /f "tokens=1,2 delims=|" %%a in (%acessos_file%) do (
      if "%%a"=="%hoje%" (
          set /a "contador=%%b+1"
          echo %%a^|!contador!
          set "encontrado=1"
      ) else (
          echo %%a^|%%b
      )
  ) ) > temp.txt
  
  if !encontrado!==0 echo %hoje%^|1 >> temp.txt
  move /y temp.txt "%acessos_file%" >nul
  
  goto telaini
}
 {
  :telaini
   @echo off
   color 4
   cls
   echo.
   echo  ██████╗  █████╗ ███╗   ███╗███████╗███████╗    ██╗  ██╗██╗   ██╗██████╗ 
   echo ██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔════╝    ██║  ██║██║   ██║██╔══██╗
   echo ██║  ███╗███████║██╔████╔██║█████╗  ███████╗    ███████║██║   ██║██████╔╝
   echo ██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ╚════██║    ██╔══██║██║   ██║██╔══██╗
   echo ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗███████║    ██║  ██║╚██████╔╝██████╔╝
   echo  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
   echo.
   echo.
   echo                 +----------------------+
   echo                 ^|                      ^|
   echo                 ^|     1. Abrir hub     ^|
   echo                 ^|    2 .Conquistas     ^|
   echo                 ^|  3. Ler Sobre o hub  ^|
   echo                 ^|       4. Sair        ^|
   echo                 ^|                      ^|
   echo                 +----------------------+ 
   echo.
   set /p opcao=Selecione sua resposta: 
   
   if "%opcao%" == "1" goto baixando
   if "%opcao%" == "2" goto conquistas
   if "%opcao%" == "3" goto mais  
   if "%opcao%" == "4" goto end
 }
  
{
  :conquistas
  @echo off
  cls

  if not exist "assets" (
      mkdir "assets"
  )

  if not exist "assets\conquistas.txt" (
      echo. > "assets\conquistas.txt"
  )
  if not exist "assets\codigos.txt" (
      echo CÓDIGOS SECRETOS: > "assets\codigos.txt"
      echo ----------------- >> "assets\codigos.txt"
      echo leet:1337 H4x0r >> "assets\codigos.txt"
      echo phantom:VPN Phantom >> "assets\codigos.txt"
      echo. >> "assets\codigos.txt"
  )
  
  :MENU
  cls
  echo   ╔════════════════════════════╗
  echo   ║                            ║
  echo   ║       HUB DE CONQUISTAS    ║
  echo   ║                            ║
  echo   ╠════════════════════════════╣
  echo   ║                            ║
  echo   ║  [1] Ver Conquistas        ║
  echo   ║  [2] Resgatar Códigos      ║
  echo   ║  [3] Sair                  ║
  echo   ║                            ║
  echo   ╚════════════════════════════╝
  echo.
  set /p choice= Escolha: 
  
  if "%choice%"=="1" goto VER_CONQUISTAS
  if "%choice%"=="2" goto RESGATAR_CODIGOS
  if "%choice%"=="3" exit
  goto MENU
  
  :VER_CONQUISTAS
  cls
  echo ╔════════════════════════════╗
  echo ║                            ║
  echo ║  CONQUISTAS DESBLOQUEADAS  ║
  echo ║                            ║
  echo ╠════════════════════════════╣                            
  if exist "assets\conquistas.txt" (
      type "assets\conquistas.txt"
  ) else (
      echo    Nenhuma conquista ainda!
  )
  echo.
  pause
  goto MENU
  
  :RESGATAR_CODIGOS
  cls
  echo ╔════════════════════════════╗
  echo ║                            ║
  echo ║   DIGITE O CÓDIGO SECRETO  ║
  echo ║                            ║
  echo ╠════════════════════════════╣
  echo .                            
  echo   Exemplo: leet              
  echo.                             
  set /p codigo= ║  Código: 
 

  if "%codigo%"=="leet" (
      call :CHECK_CONQUISTA 1 "1337 H4x0r" "Você fala a língua dos hackers!"
      goto MENU
  )
  if "%codigo%"=="phantom" (
      call :CHECK_CONQUISTA 2 "VPN Phantom" "IP: Localizado na Lua?"
      goto MENU
  )
  
  echo    Código inválido! Tente novamente.
  pause
  goto RESGATAR_CODIGOS
  
  :CHECK_CONQUISTA
  findstr /C:"[%1]" "assets\conquistas.txt" >nul
  if %errorlevel% neq 0 (
      echo [%1] %2: %3 >> "assets\conquistas.txt"
      cls
      echo ╔════════════════════════════╗
      echo ║                            ║
      echo ║  CONQUISTA DESBLOQUEADA!   ║
      echo ║                            ║
      echo ╠════════════════════════════╣
      echo                             
      echo   %2                        
      echo   %3                        
      echo.                            
      echo.
      timeout /t 3 >nul
  )
  goto :eof
}
     {
      :hub
      @echo off
      cls
      color 9  
      echo.  
      echo         ██╗ ██████╗  ██████╗  ██████╗ ███████╗
      echo         ██║██╔═══██╗██╔════╝ ██╔═══██╗██╔════╝
      echo         ██║██║   ██║██║  ███╗██║   ██║███████╗
      echo    ██   ██║██║   ██║██║   ██║██║   ██║╚════██║
      echo    ╚█████╔╝╚██████╔╝╚██████╔╝╚██████╔╝███████║
      echo     ╚════╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝                                   
      echo.  
      echo    [1] Mário 64
      echo    [2] Doom
      echo    [3] Street Fighter II
      echo    [4] Sonic the hedhehog
      echo    [5] Donkey Kong
      echo    [6] Proxima Pagina
      echo    [7] Sair
      echo.                                             
      set /p opcao=   Selecione sua resposta: 
      
      if "%opcao%" == "1" goto mario
      if "%opcao%" == "2" goto doom
      if "%opcao%" == "3" goto street
      if "%opcao%" == "4" goto sonic
      if "%opcao%" == "5" goto Donkey  
      if "%opcao%" == "6" goto hub2
      if "%opcao%" == "7" goto end
     }

     {
      :hub2
      @echo off
      cls
      color 9  
      echo.  
      echo         ██╗ ██████╗  ██████╗  ██████╗ ███████╗
      echo         ██║██╔═══██╗██╔════╝ ██╔═══██╗██╔════╝
      echo         ██║██║   ██║██║  ███╗██║   ██║███████╗
      echo    ██   ██║██║   ██║██║   ██║██║   ██║╚════██║
      echo    ╚█████╔╝╚██████╔╝╚██████╔╝╚██████╔╝███████║
      echo     ╚════╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝                                   
      echo.  
      echo    [1] Tetris
      echo    [2] Pac-Man
      echo    [3] Pokemon Red
      echo    [4] Pong Game
      echo    [5] Out Run
      echo    [6] Proxima Pagina
      echo    [7] Voltar Pagina
      echo.                                             
      set /p opcao=   Selecione sua resposta: 
      
      if "%opcao%" == "1" goto tetris
      if "%opcao%" == "2" goto pac
      if "%opcao%" == "3" goto pokemon
      if "%opcao%" == "4" goto pong
      if "%opcao%" == "5" goto out 
      if "%opcao%" == "6" goto hub3
      if "%opcao%" == "7" goto hub
     } 
    
     {
      :hub3
      @echo off
      cls
      color 9  
      echo.  
      echo         ██╗ ██████╗  ██████╗  ██████╗ ███████╗
      echo         ██║██╔═══██╗██╔════╝ ██╔═══██╗██╔════╝
      echo         ██║██║   ██║██║  ███╗██║   ██║███████╗
      echo    ██   ██║██║   ██║██║   ██║██║   ██║╚════██║
      echo    ╚█████╔╝╚██████╔╝╚██████╔╝╚██████╔╝███████║
      echo     ╚════╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝                                   
      echo.  
      echo    [1] Truco
      echo    [2] Xadrez
      echo    [3] Jogo da Velha
      echo    [4] Counter Strike 1.6
      echo    [5] Snake
      echo    [6] Proxima Pagina
      echo    [7] Voltar Pagina
      echo.                                             
      set /p opcao=   Selecione sua resposta: 
      
      if "%opcao%" == "1" goto truco
      if "%opcao%" == "2" goto xadrez
      if "%opcao%" == "3" goto velha
      if "%opcao%" == "4" goto cs
      if "%opcao%" == "5" goto snake
      if "%opcao%" == "6" goto hub4
      if "%opcao%" == "7" goto hub2
     } 

     {
      :hub4
      @echo off
      cls
      echo Ainda esta sendo feito
      pause
      goto hub3
     }

          {
           :mario
           @echo off
           cls
           start https://augustberchelmann.com/mario/
           echo. precione enter para voltar para o menu
           pause > nul
           goto hub
          }

          {
           :doom
           @echo off
           cls
           start https://dos.zone/doom-dec-1993/
           echo. precione enter para voltar para o menu
           pause > nul
           goto hub           
          }

          {
           :street
           @echo off
           cls
           start www.retrogames.cz/play_304-SNES.php
           echo. precione enter para voltar para o menu
           pause > nul
           goto hub
          }

          {
           :sonic
           @echo off
           cls
           start https://oldgameshelf.com/pt/games/sega-genesis/sonic-the-hedgehog-sega-genesis-8212
           echo. precione enter para voltar para o menu
           pause > nul
           goto hub
          }

          {
           :Donkey  
           @echo off
           cls  
           start https://jogosnainternet.com.br/jogo/donkey-kong-country-snes/
           echo. precione enter para voltar para o menu
           pause > nul
           goto hub           
          }

          {
           :tetris
           @echo off
           cls
           start https://tetris.com/play-tetris
           echo. precione enter para voltar para o menu
           pause > nul 
           goto hub2
          }

          {
           :pac
           @echo off
           cls
           start https://oldgameshelf.com/pt/games/nes/pac-man-namco-748
           echo. precione enter para voltar para o menu
           pause > nul 
           goto hub2
          }
           :pokemon
           @echo off
           cls
           start https://arcadespot.com/game/pokemon-red/
           echo. precione enter para voltar para o menu
           pause > nul 
           goto hub2
          {
           :pong
           @echo off
           cls
           start https://www.ponggame.org
           echo. precione enter para voltar para o menu
           pause > nul 
           goto hub2
          }

          {
           :out
           @echo off
           cls
           start https://www.retrogames.cz/play_171-Genesis.php
           echo. precione enter para voltar para o menu
           pause > nul 
           goto hub2
          }

          {
           :truco
           @echo off
           cls
           start https://trucoon.com.br/jogo/
           echo. precione enter para voltar para o menu
           pause > nul 
           goto hub3
          }
          
          {
           :xadrez
           @echo off
           cls
           start https://www.chess.com/pt/play/computer
           echo. precione enter para voltar para o menu
           pause > nul 
           goto hub3
          }
          
          {
           :velha
           @echo off
           cls
           start https://g.co/kgs/CKvtymu
           echo. precione enter para voltar para o menu
           pause > nul 
           goto hub3
          }
          
          {
           :cs
           @echo off
           cls
           start https://play-cs.com/pt/
           echo. precione enter para voltar para o menu
           pause > nul 
           goto hub3
          }                    
          
          {
           :snake
           @echo off
           cls
           start https://snake.io
           echo. precione enter para voltar para o menu
           pause > nul 
           goto hub3
          }
     
     {
      :mais
      @echo off 
      cls
      color 1
      echo.
      echo Este é um software que disponibiliza jogos retros e jogos para descontrair para jogar sem nenhum custo
      echo.
      echo Ele foi feito com a proposta de poder jogar em qualquer lugar.
      echo.
      echo Precione Enter para ir para o Hub.
      pause > nul
      goto telaini
     }
    {
     :baixando
     @echo off
     cls
     echo.
     echo baixando dados  
     echo. 
     color a
     setlocal enabledelayedexpansion

       set total=25

       for /L %%i in (3,3,%total%) do (

           set /a percent=%%i*100/total

           set "bar="
           for /L %%j in (1,1,%%i) do set "bar=!bar!#"
           for /L %%j in (%%i,1,%total%) do set "bar=!bar!-"

           cls

           echo                                              carregando Games Hub
           echo                                         [!bar!] !percent!%%

           timeout /nobreak /t 1 >nul
       )  
       goto hub
    }   

  {
    :end
    exit
  } 