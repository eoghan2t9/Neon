<div id="InitialSetup">
	<div class="loginform" style="margin-top:0;">
		<div class="title">
			<img src="templates/blue_default/img/logo.png" width="112" height="35" />
		</div>

		<div class="body">
	{%if isempty|ErrorMessage == false}
		<div style="z-index: 670;" class="albox errorbox">
			{%?ErrorMessage}
			<a original-title="close" href="#" class="close tips">close</a>
		</div>
	{%/if}
	<div align="center" style="margin-bottom:15px;color:#333;">
		Neon needs to collect some information about your website to setup your account for the first time.
		<br><br>
		<strong>NOTE:</strong> You can change these settings at any time!
	</div>
	<form id="SetupForm" name="SetupForm" method="post" action="post_settings.php?id=InitialSetup" onsubmit="xmlhttpPost('post_settings.php?id=InitialSetup', 'SetupForm', 'formsubmit', ''); return false;">
        <span class="st-labeltext" style="width:85px">Your Domain:</span>
        <input name="domain" type="text" class="st-forminput" id="textfield1" style="width:178px;margin-left:2px;" value="www.domain.com" onclick="this.value='';" />
        <div class="clear"></div><br>
		<span class="st-labeltext" style="width:85px;">Stats Email*:</span>
            <select name="stats" class="uniform" id="uniform-select1" style="width:150px;">
				<option value="1">Daily</option>
                <option value="7" selected="selected">Weekly</option>
				<option value="14">Twice Monthly</option>
				<option value="30">Monthly</option>
				<option value="0">Never</option>
			</select>
        <div class="clear"></div> 
		<div align="center" style="margin-top:20px;" id="formsubmit">
			<input type="submit" name="button" id="submitsetupbutton" value="Finish Setup >>" class="st-button"/>
		</div>
	</form>
	<div align="center" style="margin-top:20px;color:#333;">*How often Neon sends you statistics info on your site.</div>
		</div>
	</div>
</div>