#!/usr/bin/php -q

# Dicas para uso da notificacacao
#     1) criar o arquivo email.list no diretorio "conf" do repositorio. Nesse arquivo deve estar a lista de todos os
# 		emails que serao notificados quando houver um commit. Os emails devem estar em linhas separadas um abaixo do outro.
#				Ex: diretorio conf: /var/svn/repos<repositorio>/conf/						 
#
#			2) no direotrio hooks criar o arquivos "post-commit". Esse arquivo e executado pelo SVN toda a vez que um commit for #			realizado no reposotorio. 
#			Incluir as seguintes linhas no arquivo "post-commit".			
#				#!/bin/sh
#				REPOS="$1"
#				REV="$2"
#				/var/svn/conf/./send.email.shell.php.sh $REPOS $REV
#
#		 	3) Esse script pode ser salvo em um diretorio conf na pasta raiz de instalacao do SVN. 
#				


<?php
  
  # define as informacoes de localidade e encoding

  putenv('LANG=en_US.UTF-8');
  
  $repos = $argv[1];
  $rev   = $argv[2];    
      
  $FILE = $repos."/conf/email.list"; 
  
  
        
  function listFiles( $files ) 
  {
    $string = "<ul>";								
		foreach($files as $index => $array )
		{   
			  $string .= "<li>". ( $files[$index]["tp"] )." ". ( $files[$index]["arquivo"] )."</li>";											
		}   
   	$string .= "</ul>";
					
		return $string;				
  }  
    


  function explodeFilesChanged($changed) 
  {

    $result = array( array( ) ); 
        
    $files = explode( "\n", $changed );
    foreach ( $files as $index => $array  ) 
    {
          
      $file = trim($files[$index]); 
      if ( ! empty ($file) ) 
      {         
        $tp = "#";
        $arquivo = $file;
        
        $pos = strpos($file, " ");
                   
        if ( is_integer($pos ) )
        {
        	$arquivo = trim( substr( $file, $pos ) );
        	$__tp = trim( substr( $file, 0, $pos ) );   
        	 	
        	
        	switch ( $__tp ) {
						case "A":
						  $tp = "+";
							break;
						case "D":
							$tp = "-";
							break;
						case "U":
							$tp = "*";
							break;						
						} 									
        }
                                
      	$value = array( "tp" => $tp, "arquivo" => $arquivo );           
      	$result[$index] = $value;           
      }                                	
    }   
    
    return $result;
  }  
    
    
    
  function getEmailNotify( $fileemails ) 
  {     	   	
    $emails = "";  
              
		if ( file_exists( $fileemails ) ) 
		{			
			$result = fopen( $fileemails , "r"  );		   
			if ( $result ) {	  			 
				while( ! feof( $result ) ) 
				{
			  	$linha = trim( fgets( $result, 4096 ) );			  	
			  	if ( ! empty( $linha ) ) {	  
			  	  if (filter_var( $linha, FILTER_VALIDATE_EMAIL )  ) 
			  	  {			  	   	  
	 	    	  	$emails .= $linha.";" ;
	 	    	  }	 	    	   	   
			  	}	   		
				}	  				
				fclose( $result );
			}	 
		}   		 
    return $emails;  
  }
 
 
 
  $author = trim( shell_exec( "svnlook author -r $rev $repos" ) );
  $date = trim( shell_exec( "svnlook date -r $rev $repos" ) ); 
  $log = trim( exec( "svnlook log -r $rev $repos" ) ) ;  
  $files = trim( shell_exec( "svnlook changed -r $rev $repos" ) ); 
  $project = trim( basename( $repos ) );  


  $subject = "$author comitou no projeto $project";

  $from = "microsys.mailer@gmail.com";

  $to = trim( getEmailNotify( $FILE ) );
  $listfiles = explodeFilesChanged($files);

  $headers  = 'MIME-Version: 1.1' . "\r\n";
  $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
  $headers .= 'To: Microsys SVN <microsys.mailer@gmail.com>' . "\r\n";

  $message = "
	<!DOCTYPE html>
	<html>
	<body>

		<div style=\"border: 4px solid #154372; margin: 0px;\">
	
			<div style=\"background-color:#336699; padding: 10px; margin: 0px;\">			
				<p style=\"font-family: verdana, sans-serif; font-size: 14px; color: #FFFFFF; margin: 0px;\">Autor: $author</p>
				<p style=\"font-family: verdana, sans-serif; font-size: 14px; color: #FFFFFF; margin: 0px;\">Revisao: $rev</p>
				<p style=\"font-family: verdana, sans-serif; font-size: 14px; color: #FFFFFF; margin: 0px;\">Repositorio: $project</p>
				<p style=\"font-family: verdana, sans-serif; font-size: 14px; color: #FFFFFF; margin: 0px;\">Data: $date</p>						
			</div>	

			<div style=\"padding: 10px; margin: 0px; \">".
			

				(( (! empty($log)) ) ? "<div style=\"font-family: verdana, sans-serif; font-size: 14px; color: #000000; margin: 10px;\"><b>Log</b></div>	
				<div style=\"text-indent: 15px; -webkit-border-radius: 15px; border-radius: 15px;  background-color: #FFFFCC; padding: 10px; font-family: verdana, sans-serif; font-size: 12px; border: 2px solid  #FFCC00;\">".  ( $log ) ."</div>" : "" )
			
			
				."
				<div style=\"font-family: verdana, sans-serif; font-size: 14px; color: #000000; margin: 10px;\"><b>Fontes alterados</b></div>				
				<div style=\"text-indent: 5px; -webkit-border-radius: 15px; border-radius: 15px;  background-color: #FFFFCC; padding: 10px; font-family: verdana, sans-serif; font-size: 12px; border: 2px solid  #FFCC00;\">".	
             				
						listFiles( $listfiles )
					
				."</div>			
			</div>

			<div style=\"background-color:#336699; text-align:center; padding: 10px; margin: 0px;\">
				<p style=\"font-family: verdana, sans-serif; font-size: 14px; color: #FFFFFF; margin: 0px;\">Microsys Sistemas Ltda</p>
			</div>
		</div>
	</body>
	</html>
  ";




if (! empty($to) )
  mail("$to","$subject","$message", $headers);  	 
  
?>
