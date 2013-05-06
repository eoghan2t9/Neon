<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{%?PanelTitle} - {%?PageTitle}</title>
    <link rel="stylesheet" type="text/css" href="templates/blue_default/style/reset.css" /> 
    <link rel="stylesheet" type="text/css" href="templates/blue_default/style/root.css" /> 
    <link rel="stylesheet" type="text/css" href="templates/blue_default/style/grid.css" /> 
    <link rel="stylesheet" type="text/css" href="templates/blue_default/style/typography.css" /> 
    <link rel="stylesheet" type="text/css" href="templates/blue_default/style/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" href="templates/blue_default/style/jquery-plugin-base.css" />
	<link rel="stylesheet" type="text/css" href="templates/blue_default/style/basic.css" />
    <!--[if IE 7]>	  <link rel="stylesheet" type="text/css" href="templates/blue_default/style/ie7-style.css" />	<![endif]-->
	<!--[if lt IE 7]> <link type='text/css' href='css/basic_ie.css' rel='stylesheet' media='screen' /> <![endif]-->
	<script type="text/javascript" src="templates/blue_default/js/jquery.min.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery-ui-1.8.11.custom.min.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery-settings.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/toogle.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.tipsy.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.uniform.min.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.wysiwyg.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.tablesorter.min.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/raphael.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/analytics.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/popup.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/fullcalendar.min.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.prettyPhoto.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.ui.core.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.ui.mouse.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.ui.slider.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.ui.datepicker.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.ui.tabs.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.ui.accordion.js"></script>
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.simplemodal.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/basic.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/jquery.form.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/ajaxsubmit.js"></script>
	<script type="text/javascript" src="templates/blue_default/js/plupload.full.js"></script>
	{%if isset|MysqlPage == true}
		<script type="text/javascript">
			$(document).ready(function(){
				$("#mysqlmenu").slideToggle();
			});
		</script>
	{%/if}
</head>
<body>
<div class="wrapper">
	<!-- START HEADER -->
    <div id="header">
    	<!-- logo -->
    	<div class="logo">	<a href="main.php"><img src="templates/blue_default/img/logo.png" width="187" height="68" alt="logo"/></a>	</div>

        <!-- notifications -->
        <div id="notifications">
        	<a href="index.php" class="qbutton-left"><img src="templates/blue_default/img/icons/header/dashboard.png" width="16" height="15" alt="Dashboard" /></a>
        	<a href="news.php" class="qbutton-normal tips"><img src="templates/blue_default/img/icons/header/message.png" width="19" height="13" alt="News" /></a>
        	<a href="stats.php" class="qbutton-right"><img src="templates/blue_default/img/icons/header/graph.png" width="19" height="13" alt="support" /></a>
          <div class="clear"></div>
        </div>

        <!-- profile box -->
        <div id="profilebox">
        	<a href="#" class="display">
            	<img src="templates/blue_default/img/simple.jpg" width="33" height="33" alt="profile"/>	<b>Logged in as</b>	<span>{%?Username}</span>
            </a>
            
            <div class="profilemenu">
            	<ul>
                	<li><a href="settings.php">Account Settings</a></li>
                	<li><a href="logout.php">Logout</a></li>
                </ul>
            </div>
            
        </div>
        
        
        <div class="clear"></div>
    </div>
    <!-- END HEADER -->
    <!-- START MAIN -->
    <div id="main">
        <!-- START SIDEBAR -->
        <div id="sidebar">
        	
            <!-- start searchbox -->
            <div id="searchbox">
            	<div class="in">
               	  <form id="form1" name="form1" method="post" action="">
                  	<input name="textfield" type="text" class="input" id="textfield" onfocus="$(this).attr('class','input-hover')" onblur="$(this).attr('class','input')"  />
               	  </form>
            	</div>
            </div>
            <!-- end searchbox -->
            
            <!-- start sidemenu -->
            <div id="sidemenu">
            	<ul>
                	<li{%if PageName == main} class="active"{%/if}><a href="index.php"><img src="templates/blue_default/img/icons/sidemenu/laptop.png" width="16" height="16" alt="icon"/>Dashboard</a></li>
                    <li{%if PageName == filemanager} class="active"{%/if}><a href="filemanager.php"><img src="templates/blue_default/img/icons/sidemenu/file.png" width="16" height="16" alt="icon"/>File Manager</a></li>
                    <li{%if PageName == email} class="active"{%/if}><a href="email.php"><img src="templates/blue_default/img/icons/sidemenu/mail.png" width="16" height="16" alt="icon"/>Email Accounts</a></li>
					<li class="subtitle">
                    	<a class="action tips-right" href="#" title="Mysql"><img src="templates/blue_default/img/icons/sidemenu/file_edit.png" width="16" height="16" alt="icon"/>MySQL<img src="templates/blue_default/img/arrow-down.png" width="7" height="4" alt="arrow" class="arrow" /></a>
                    	<ul class="submenu" id="mysqlmenu">
							<li{%if PageName == databases} class="active"{%/if}><a href="mysql.php?view=databases"><img src="templates/blue_default/img/icons/sidemenu/file.png" width="16" height="16" alt="icon"/>Databases</a></li>
							<li{%if PageName == users} class="active"{%/if}><a href="mysql.php?view=users"><img src="templates/blue_default/img/icons/sidemenu/user.png" width="16" height="16" alt="icon"/>Users</a></li>
							<li{%if PageName == databaseusers} class="active"{%/if}><a href="mysql.php?view=databaseusers"><img src="templates/blue_default/img/icons/sidemenu/vcard.png" width="16" height="16" alt="icon"/>Database Users</a></li>
							<li{%if PageName == wizard} class="active"{%/if}><a href="mysql.php?view=wizard"><img src="templates/blue_default/img/icons/sidemenu/star.png" width="16" height="16" alt="icon"/>Creation Wizard</a></li>
							<li><a href="./phpmyadmin/index.php" target="_blank"><img src="templates/blue_default/img/icons/sidemenu/pma.png" width="16" height="16" alt="icon"/>PHPMyAdmin</a></li>
                        </ul>
                    </li>
					<li{%if PageName == ftp} class="active"{%/if}><a href="ftp.php"><img src="templates/blue_default/img/icons/sidemenu/copy.png" width="16" height="16" alt="icon"/>FTP Manager</a></li>
                    <li{%if PageName == dns} class="active"{%/if}><a href="dns.php"><img src="templates/blue_default/img/icons/sidemenu/star.png" width="16" height="16" alt="icon"/>DNS Editor</a></li>
					<li{%if PageName == domainmanager} class="active"{%/if}><a href="domainmanager.php"><img src="templates/blue_default/img/icons/sidemenu/photo.png" width="16" height="16" alt="icon"/>Domain Manager</a></li>
					<li{%if PageName == settings} class="active"{%/if}><a href="settings.php"><img src="templates/blue_default/img/icons/sidemenu/lock.png" width="16" height="16" alt="icon"/>Server Settings</a></li>
                    <li{%if PageName == backups} class="active"{%/if}><a href="backups.php"><img src="templates/blue_default/img/icons/sidemenu/download.png" width="16" height="16" alt="icon"/>Backups</a></li>
                    <li{%if PageName == process} class="active"{%/if}><a href="process.php"><img src="templates/blue_default/img/icons/sidemenu/error.png" width="16" height="16" alt="icon"/>Processes</a></li>
                    <li{%if PageName == help} class="active"{%/if}><a href="help.php"><img src="templates/blue_default/img/icons/sidemenu/info.png" width="16" height="16" alt="icon"/>Help & Information</a></li>
					<li{%if PageName == update} class="active"{%/if}><a href="update.php"><img src="templates/blue_default/img/icons/sidemenu/download.png" width="16" height="16" alt="icon"/>Check For Updates</a></li>
                </ul>
            </div>
            <!-- end sidemenu -->
            
        </div>
        <!-- END SIDEBAR -->

        <!-- START PAGE -->
        <div id="page" style="margin:0;">
		<div id="LoadingImage" align="right" style="padding-right:10px;margin-top:10px;visibility:hidden;"><img src="./templates/blue_default/img/loading/9.gif"></img></div>
		{%?Content}
		</div>
		
    <div class="clear"></div>
    </div>
    <!-- END MAIN -->
    <!-- START FOOTER -->
    <div id="footer">
    	<div class="left-column">{%?PanelTitle}</div>
        <div class="right-column">&copy Copyright 2012 - <a href="http://neonpanel.com" target="_blank">NEON</a> - All rights reserved.</div>
    </div>
    <!-- END FOOTER -->

</div>
</body>
</html>