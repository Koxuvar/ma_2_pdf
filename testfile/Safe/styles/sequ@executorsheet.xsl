<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ma="http://schemas.malighting.de/grandma2/xml/MA" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<!-- MA Lighting grandMA Release Version 2.5.0 ********************************************************************************* -->

<xsl:output
	method="html"
	indent="yes"
	encoding="utf-8"
	media-type="text/html"
	doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:decimal-format NaN=""/>

<xsl:template match="/">
    <html>
        <head>
            <title>Sequence Exec Sheet</title>
            <link type="text/css" rel="stylesheet" href="styles/include/style.css" />
        </head>
        <body>
            <div id="divAll">
                <xsl:apply-templates/>
            </div>
        </body>
    </html>
</xsl:template>

<!-- *************************************************************************************************************************** -->
<xsl:template match="ma:Sequ">
<!--
	<h1>Sequence <xsl:value-of  select="@index +1" /> &quot;<xsl:value-of  select="@name" />&quot;</h1>  
	-->

	<table class="Cue">
		<tr>
<!--Cue-->			
			<th>CueNum </th>
			<th>CuePart </th>
			<th>Cue </th>
			<th>Cue Info </th>
			
			<th>Trigger</th>
			<th>TTime</th>
			<th>Mode</th>
			<th>Loop</th>
			<th>Ltime</th>
			<th>LCnt</th>
<!--CuePart-->			
			<th>Fade</th>
			<th>Outfade</th>
			<th>Delay</th>
			<th>Outdelay</th>
			<th>Snap%</th>
			<th>MIB</th>
<!--			<th>MIB Cue</th> -->
			<th>AE</th>
			<th>CMD</th>
			<th>CMD Delay</th>
			<th>Path</th>
		</tr>

			<xsl:apply-templates select="ma:Cue" />

	</table>	
</xsl:template>  

<!-- *************************************************************************************************************************** -->
<xsl:template match="ma:Cue">
<xsl:choose>
<xsl:when test="@index>0">

	<xsl:apply-templates select="ma:CuePart[@index]" />
</xsl:when>
</xsl:choose>

</xsl:template>  
 
<!-- *************************************************************************************************************************** -->
 <xsl:template match="ma:CuePart" >

			<tr>
			<td class="colString">	
				<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="../ma:Number"/></xsl:call-template>		

			</td>
			<td class="colString">	
			<xsl:choose>

				<xsl:when test="@index">
				<xsl:value-of  select="@index" />
				</xsl:when>
			</xsl:choose>

			</td>
			<td class="colString">	
			<xsl:choose>
				<xsl:when test="@name">
					<xsl:value-of  select="@name" />
				</xsl:when>
			</xsl:choose>
			</td>

			<td class="colString">
			<xsl:choose>
				<xsl:when test="../ma:InfoItems/ma:Info/text()">
					<xsl:value-of  select="../ma:InfoItems/ma:Info/text()" />
				</xsl:when>
			</xsl:choose>

			</td>
			<td class="colString">	
					<xsl:choose>
				<xsl:when test="../ma:Trigger">
							<xsl:value-of  select="../ma:Trigger/@type" />
						</xsl:when>
						<xsl:otherwise>Go</xsl:otherwise>
					</xsl:choose>
			</td>

			<td class="colString">	
					<xsl:choose>
						<xsl:when test="../ma:Trigger">
							<xsl:if test="../ma:Trigger/@data_f &gt; 0">
								<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="../ma:Trigger/@data_f"/></xsl:call-template>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
			</td>

			<td class="colString">	
					<xsl:choose>
						<xsl:when test="../@cue_mode">
						<xsl:value-of  select="../@cue_mode" />
						</xsl:when>	
					</xsl:choose>
	
			</td>

			<td class="colString">	
				<xsl:choose>
					<xsl:when test="../ma:LoopDestination">
							<xsl:attribute name="href">cue<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="../ma:LoopDestination"/></xsl:call-template></xsl:attribute>
							<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="../ma:LoopDestination"/></xsl:call-template>	
						
					</xsl:when>
					<xsl:otherwise>-</xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="colString">	
				<xsl:choose>
					<xsl:when test="../ma:LoopDestination">
						<xsl:if test="../../ma:Cue/@loop_time"><xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="../../ma:Cue/@loop_time"/></xsl:call-template></xsl:if>	
					</xsl:when>
					<xsl:otherwise>-</xsl:otherwise>
				</xsl:choose>
			</td>

			<td class="colString">	
				<xsl:choose>
					<xsl:when test="../ma:LoopDestination">
						<xsl:text> </xsl:text>
						<xsl:if test="../../ma:Cue/@loop_count"><xsl:value-of  select="../../ma:Cue/@loop_count" /></xsl:if>	
					</xsl:when>
					<xsl:otherwise>-</xsl:otherwise>
				</xsl:choose>
			</td>




			<td class="colString">	
					<xsl:choose>
						<xsl:when test="@basic_fade">
							<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="@basic_fade"/></xsl:call-template>
						</xsl:when>
					</xsl:choose>
			</td>

			<td class="colString">	
					<xsl:choose>
						<xsl:when test="@basic_downfade">
								<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="@basic_downfade"/></xsl:call-template>
						</xsl:when>
					</xsl:choose>
			</td>
			<td class="colString">	
					<xsl:choose>
						<xsl:when test="@basic_delay">
								<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="@basic_delay"/></xsl:call-template>
						</xsl:when>
					</xsl:choose>
			</td>
			<td class="colString">	
					<xsl:choose>
						<xsl:when test="@basic_downdelay">
								<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="@basic_downdelay"/></xsl:call-template>
						</xsl:when>
					</xsl:choose>
			</td>
			<td class="colString">	
					<xsl:choose>
						<xsl:when test="@basic_snap_percent">
						<xsl:value-of  select="@basic_snap_percent" />

						</xsl:when>
					</xsl:choose>
			</td>
			<td class="colString">	
					<xsl:choose>
							
						<xsl:when test="../@mib_sign=-1">
							<xsl:choose>
								<xsl:when test="../ma:MibCue/@number=0 and ../ma:MibCue/@sub_number=1">
										late
								</xsl:when>	
								<xsl:otherwise>
									-<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="../ma:MibCue"/></xsl:call-template>	
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>	

						<xsl:otherwise>
							<xsl:choose>
						
								<xsl:when test="../ma:MibCue/@number=0 and ../ma:MibCue/@sub_number=0">
										early
								</xsl:when>	
								<xsl:otherwise>
									<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="../ma:MibCue"/></xsl:call-template>	
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>	
	

					</xsl:choose>
			</td>
<!--
			<td class="colString">	
					<xsl:choose>
						<xsl:when test="../ma:MibCue">
						<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="../ma:MibCue"/></xsl:call-template>	
						</xsl:when>	
					</xsl:choose>
		
			</td>
-->
			<td class="colString">	
			<xsl:choose>
					<xsl:when test="@force_effect_time">
					<xsl:value-of  select="@force_effect_time" />
			</xsl:when>	
			</xsl:choose>
			</td>

			<td class="colString">	
				<xsl:choose>
					<xsl:when test="ma:macro_text">
						<xsl:value-of  select="ma:macro_text/text()" />
					</xsl:when>	
				</xsl:choose> 
			</td>
			
			<td class="colString">	
					<xsl:choose>
						<xsl:when test="@cmd_delay">
							<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="@cmd_delay"/></xsl:call-template>
						</xsl:when>
					</xsl:choose>
			</td>

			<td class="colString">	
					<xsl:call-template name="AddressLinkFormatter"><xsl:with-param name="addressLink" select="ma:FadePath"/></xsl:call-template>

			</td>

		<xsl:call-template name="CueDatas">
		<xsl:with-param name="value_multipart_index" select="@index"/>
		<xsl:with-param name="effect_multipart_index" select="@index"/>
		</xsl:call-template>
	</tr>

	</xsl:template>  

<!-- *************************************************************************************************************************** -->
 
 <xsl:template name="CueDatas" >
	<xsl:param name="value_multipart_index" /> 
	<xsl:param name="effect_multipart_index" /> 
		<xsl:apply-templates select="./../ma:CueDatas/ma:CueData[@value_multipart_index=$value_multipart_index ] | ./../ma:CueDatas/ma:CueData[@effect_multipart_index=$effect_multipart_index ] ">
				<xsl:with-param name="value_multipart_index" select="$value_multipart_index "/>
				<xsl:with-param name="effect_multipart_index" select="$effect_multipart_index "/>
		</xsl:apply-templates>
		
</xsl:template>  

<!-- *************************************************************************************************************************** -->
 
 <xsl:template match="ma:CueData" >
 	<xsl:param name="value_multipart_index" /> 
	<xsl:param name="effect_multipart_index" /> 
</xsl:template>  
<!-- *************************************************************************************************************************** -->
<xsl:template name="CueFormatter">
	<xsl:param name="cueNumber" /> 

		<xsl:choose>
			<xsl:when test="ma:CuePart/@name">
				<xsl:value-of  select="ma:CuePart/@name" />
			</xsl:when>
		</xsl:choose>

</xsl:template>
<!-- *************************************************************************************************************************** -->
<xsl:template name="ValueFormatter">

	<xsl:param name="CurrentValue" /> 
	<span class="key">
	<xsl:copy-of select="$CurrentValue"/>:
	</span>
</xsl:template>
 

<!-- *************************************************************************************************************************** -->
<xsl:template name="TimeFormatter">
	<xsl:param name="time" /> 
	<xsl:choose>
		<xsl:when test="$time">
			<xsl:variable name="hours" select="floor($time div 3600)"/> 
			<xsl:variable name="minutes" select="floor(($time div 60) mod 60)"/> 
			<xsl:variable name="seconds" select="$time mod 60"/> 
			<xsl:choose>
				<xsl:when test="$hours &gt; 0">
					<xsl:value-of select="$hours"/>:<xsl:value-of select="format-number($minutes, '00')"/>:<xsl:value-of select="format-number($seconds, '00')"/>
				</xsl:when>
				<xsl:when test="$minutes &gt; 0">
					<xsl:value-of select="format-number($minutes, '#0')"/>:<xsl:value-of select="format-number($seconds, '00')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number($seconds, '0.#')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
	</xsl:choose>
</xsl:template>
<!-- *************************************************************************************************************************** -->
<xsl:template name="Textout">

	<xsl:param name="Display" /> 
	<span class="key">
	<xsl:copy-of select="$Display"/>:
	</span>
</xsl:template>
 
<!-- *************************************************************************************************************************** -->
<xsl:template name="CueNumberFormatter">
	<xsl:param name="cueNumber" /> 
	<xsl:value-of  select="$cueNumber/@number" />
	<xsl:if test="$cueNumber/@sub_number &gt; 0"><xsl:value-of  select="format-number($cueNumber/@sub_number div 1000,'.###')" /></xsl:if>
</xsl:template>

<!-- *************************************************************************************************************************** -->
<xsl:template name="ChannelLinkFormatter">
	<xsl:param name="channelLink" /> 
	<xsl:choose>
		<xsl:when test="$channelLink/@fixture_id>0"><xsl:value-of  select="$channelLink/@fixture_id" /></xsl:when>
		<xsl:otherwise>-</xsl:otherwise>
	</xsl:choose>/<xsl:choose>
		<xsl:when test="$channelLink/@channel_id>0"><xsl:value-of  select="$channelLink/@channel_id" /></xsl:when>
		<xsl:otherwise>-</xsl:otherwise>
	</xsl:choose>
		<xsl:choose>
		<xsl:when test="$channelLink/@subfixture_id>0">
			.<xsl:value-of  select="$channelLink/@subfixture_id" />
		</xsl:when>
	</xsl:choose>
	<xsl:text> </xsl:text>
	<xsl:value-of  select="$channelLink/@attribute_name" />
</xsl:template>

<!-- *************************************************************************************************************************** -->
<xsl:template name="AddressLinkFormatter">
	<xsl:param name="addressLink" /> 
	<xsl:for-each select="$addressLink/ma:No">
		<xsl:choose>
			<xsl:when test="position()>1">.</xsl:when>
		</xsl:choose>
		<xsl:value-of select="."/>
	</xsl:for-each>
	<xsl:text> </xsl:text>
	<xsl:choose>
			<xsl:when test="$addressLink/@name">
				&quot;<xsl:value-of  select="$addressLink/@name" />&quot;
			</xsl:when>
		</xsl:choose>
</xsl:template>
<!-- *************************************************************************************************************************** -->
 
</xsl:stylesheet>

