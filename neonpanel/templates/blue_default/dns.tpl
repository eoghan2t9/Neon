<div align="center" class="DNSHome">
	{%if isset|Domain == false}
		<div class="simplebox grid740">
			<div class="titleh">
				<h3>DNS Domain Selection</h3>
			</div>
			<table id="UserTable" class="tablesorter"> 
				<thead> 
					<tr> 
						<th style="width:100%">Domain</th> 
					</tr> 
				</thead> 
				<tbody>
					{%if isset|DomainList == false}
						<tr>
							<td>
								<div align="center">You must add a domain before you can add DNS records.</div>
							</td>
						</tr>
					{%/if}
					{%if isset|DomainList == true}
						{%foreach entry in DomainList}
							<tr>
								<td><a href="dns.php?domain={%?entry}">{%?entry}</a></td>
							</tr>
						{%/foreach}
					{%/if}
				</tbody> 
			</table>
		</div>
	{%/if}
	{%if isset|Domain == true}
		{%if isset|Edit == true}
			<div class="simplebox grid740" style="text-align:left;">
				<div class="titleh">
					<h3>Edit Record</h3>
				</div>
				{%foreach listing in Edit}
					<div class="body">
						<form id="form2" name="form2" method="post" action="dns.php?domain={%?Domain}&action=edit_record&update=1&record={%?Record}">
							<div class="st-form-line">	
								<span class="st-labeltext">Entry:</span>	
								<input name="name" type="text" class="st-forminput" id="name" style="width:250px" value="{%?listing[name]}" /> 
								<div class="clear"></div>
							</div>
							<div class="st-form-line">
								<span class="st-labeltext">Type:</span>	
								<select name="type" id="type" class="uniform" style="width:250px">
									<option value="A"{%if listing[type] == A} selected="selected"{%/if}>A</option>
									<option value="AAAA"{%if listing[type] == AAAA} selected="selected"{%/if}>AAAA</option>
									<option value="CNAME"{%if listing[type] == CNAME} selected="selected"{%/if}>CNAME</option>
									<option value="MX"{%if listing[type] == MX} selected="selected"{%/if}>MX</option>
									<option value="NS"{%if listing[type] == NS} selected="selected"{%/if}>NS</option>
									<option value="SOA"{%if listing[type] == SOA} selected="selected"{%/if}>SOA</option>
									<option value="SPF"{%if listing[type] == SPF} selected="selected"{%/if}>SPF</option>
									<option value="SRV"{%if listing[type] == SRV} selected="selected"{%/if}>SRV</option>
									<option value="TXT"{%if listing[type] == TXT} selected="selected"{%/if}>TXT</option>
								</select>
								<div class="clear"></div>
							</div>
							<div class="st-form-line">	
								<span class="st-labeltext">Record:</span>	
								<input name="content" type="text" class="st-forminput" id="content" style="width:250px" value="{%?listing[content]}" /> 
								<div class="clear"></div>
							</div>
							<div class="button-box">
								<input type="submit" name="button" id="button" value="Submit" class="st-button"/>
							</div>
						</form>
					</div>
				{%/foreach}
			</div>
		{%/if}
		{%if isset|Edit == false}
			<div class="simplebox grid740">
				<div class="titleh">
					<h3>DNS Management for {%?Domain}</h3>
				</div>
				<table id="UserTable" class="tablesorter"> 
					<thead> 
						<tr> 
							<th style="width:30%">Record</th>
							<th style="width:10%">Type</th>
							<th style="width:50%">Content</th>
							<th style="width:10%">Delete</th>
						</tr> 
					</thead> 
					<tbody>
						{%if isset|Records == false}
							<tr>
								<td>
									<div align="center">Somehow... magically there is no DNS set for this domain on this server.</div>
								</td>
							</tr>
						{%/if}
						{%if isset|Records == true}
							{%foreach entry in Records}
								<tr>
									<td><a href="dns.php?domain={%?Domain}&action=edit_record&record={%?entry[id]}">{%?entry[name]}</a></td>
									<td><div align="center">{%?entry[type]}</div></td>
									<td>{%?entry[content]}</td>
									<td><div align="center"><a original-title="Delete" class="icon-button tips" style="padding-left:5px;padding-right:5px;cursor:pointer;" href="dns.php?domain={%?Domain}&action=delete_record&record={%?entry[id]}"><img src="./templates/blue_default/img/icons/32x32/stop32.png" alt="icon" height="16" width="16"></a></div></td>
								</tr>
							{%/foreach}
						{%/if}
					</tbody> 
				</table>
			</div>
			<br><br>
			<div class="simplebox grid740" style="text-align:left;">
				<div class="titleh">
					<h3>Add Record</h3>
				</div>
				<div class="body">
					<form id="form2" name="form2" method="post" action="dns.php?domain={%?Domain}&action=add_record">
						<div class="st-form-line">	
							<span class="st-labeltext">Entry:</span>	
							<input name="name" type="text" class="st-forminput" id="name" style="width:250px" value="example.domain.com" onclick="this.value='';" /> 
							<div class="clear"></div>
						</div>
						<div class="st-form-line">
							<span class="st-labeltext">Type:</span>	
							<select name="type" id="type" class="uniform" style="width:250px">
								<option value="A">A</option>
								<option value="AAAA">AAAA</option>
								<option value="CNAME">CNAME</option>
								<option value="MX">MX</option>
								<option value="NS">NS</option>
								<option value="SOA">SOA</option>
								<option value="SPF">SPF</option>
								<option value="SRV">SRV</option>
								<option value="TXT">TXT</option>
							</select>
							<div class="clear"></div>
						</div>
						<div class="st-form-line">	
							<span class="st-labeltext">Record:</span>	
							<input name="content" type="text" class="st-forminput" id="content" style="width:250px" value="{%?DefaultIP}" /> 
							<div class="clear"></div>
						</div>
						<div class="button-box">
							<input type="submit" name="button" id="button" value="Submit" class="st-button"/>
						</div>
					</form>
				</div>
			</div>
		{%/if}
	{%/if}
</div>