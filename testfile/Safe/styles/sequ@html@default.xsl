<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ma="http://schemas.malighting.de/grandma2/xml/MA" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<xsl:output
	method="html"
	indent="yes"
	encoding="utf-8"
	media-type="text/html"
	doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:template match="/">
	<html>
		<head>
			<title>Exported Data</title>
			<link type="text/css" rel="stylesheet" href="styles/include/style.css" />
		</head>
		<body>
			<div id="divAll">
				<div id="divBodyHeader">
					<img id="imgLogo" src="styles/include/ma_lighting_logo.png" alt="MA Lighting" />
				</div>
				<div id="divBodyContent">
					<xsl:apply-templates />
				</div>
				<div id="divBodyFooter">
					This a predefined template to display exported xml files. See into the &quot;styles&quot; folder to change that templates.
				</div>
			</div>
		</body>
	</html>
</xsl:template>

<xsl:template match="ma:Info" >
	<div class="fileinfo">
		<ul>
			<li>
				<span class="key">Show: </span>
				<span class="value">
					<xsl:value-of  select="@showfile" />
				</span>
			</li>
			<li>
				<span class="key">Export Date: </span>
				<span class="value">
					<xsl:value-of  select="@datetime" />
				</span>
			</li>
		</ul>
	</div>
 </xsl:template>

<xsl:template name="AlternatingTrClass">
	<xsl:param name="index" />
	<xsl:choose>
		<xsl:when test="$index mod 2 = 1">
			<xsl:attribute name="class">row1</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="class">row2</xsl:attribute>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:template match="ma:Sequ">
	<h1>Sequence <xsl:value-of  select="@index +1" /> &quot;<xsl:value-of  select="@name" />&quot;</h1>
	<xsl:apply-templates select="ma:Cue" />
</xsl:template>

<xsl:template match="ma:Cue">
	<h2>
		<a><xsl:attribute name="name">#cue<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="ma:Number"/></xsl:call-template></xsl:attribute></a>
		Cue <xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="ma:Number"/></xsl:call-template>
		<xsl:choose>
			<xsl:when test="ma:CuePart/@name">
				&quot;<xsl:value-of  select="ma:CuePart/@name" />&quot;
			</xsl:when>
		</xsl:choose>
	</h2>

	<ul>
		<li>
			<span class="key">Trigger: </span>
			<span class="value">
				<xsl:choose>
					<xsl:when test="ma:Trigger">
						<xsl:value-of  select="ma:Trigger/@type" />
						<xsl:if test="ma:Trigger/@data_f &gt; 0"> &#160;
							<xsl:if test="ma:Trigger/@type = 'Follow'"> + </xsl:if>
							<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="ma:Trigger/@data_f"/></xsl:call-template>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>Go</xsl:otherwise>
				</xsl:choose>
			</span>
		</li>
		<li>
			<span class="key">Mode: </span>
			<span class="value">
				<xsl:choose>
					<xsl:when test="@cue_mode">
						<xsl:value-of  select="@cue_mode" />
					</xsl:when>
					<xsl:otherwise>Normal</xsl:otherwise>
				</xsl:choose>
			</span>
		</li>
		<li>
			<span class="key">Loop: </span>
			<span class="value">
				<xsl:choose>
					<xsl:when test="ma:LoopDestination">
						Loop to
						<a>
							<xsl:attribute name="href">#cue<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="ma:LoopDestination"/></xsl:call-template></xsl:attribute>
							<xsl:text>Cue </xsl:text>
							<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="ma:LoopDestination"/></xsl:call-template>
						</a>
						<xsl:text> </xsl:text>
						<xsl:if test="@loop_time"> for <xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="@loop_time"/></xsl:call-template> seconds</xsl:if>
						<xsl:if test="@loop_count and @loop_time"> or </xsl:if>
						<xsl:if test="@loop_count"><xsl:value-of  select="@loop_count" /> times</xsl:if>
					</xsl:when>
					<xsl:otherwise>-</xsl:otherwise>
				</xsl:choose>
			</span>
		</li>
	</ul>
	<xsl:apply-templates select="ma:CuePart[@index]" />
 </xsl:template>

 <xsl:template match="ma:CuePart" >
	<h3>
		CuePart <xsl:value-of  select="@index" />
		<xsl:choose>
			<xsl:when test="@name">
				&quot;<xsl:value-of  select="@name" />&quot;
			</xsl:when>
		</xsl:choose>
	</h3>

	<ul>
		<xsl:choose>
			<xsl:when test="@basic_fade">
				<li>
					<span class="key">Fade: </span>
					<span class="value">
						<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="@basic_fade"/></xsl:call-template>
					</span>
				</li>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="@basic_downfade">
				<li>
					<span class="key">Out Fade: </span>
					<span class="value">
						<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="@basic_downfade"/></xsl:call-template>
					</span>
				</li>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="@basic_delay">
				<li>
					<span class="key">Delay: </span>
					<span class="value">
						<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="@basic_delay"/></xsl:call-template>
					</span>
				</li>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="@basic_downdelay">
				<li>
					<span class="key">Out Delay: </span>
					<span class="value">
						<xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="@basic_downdelay"/></xsl:call-template>
					</span>
				</li>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="@basic_snap_percent">
				<li>
					<span class="key">Snap Percent: </span>
					<span class="value">
						<xsl:value-of  select="@basic_snap_percent" />%
					</span>
				</li>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="@mib_sign">
				<li>
					<span class="key">MIB Sign: </span>
					<span class="value">
						<xsl:value-of  select="@mib_sign" />
					</span>
				</li>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="ma:MibCue">
				<li>
					<span class="key">Mib Cue: </span>
					<span class="value">
						<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="ma:MibCue"/></xsl:call-template>
					</span>
				</li>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="ma:MibCue">
				<li>
					<span class="key">AE: </span>
					<span class="value">
						<xsl:value-of  select="@force_effect_time" />
					</span>
				</li>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="ma:Info">
				<li>
					<span class="key">Cmd: </span>
					<span class="value">
						<xsl:value-of  select="ma:text" />
					</span>
				</li>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="cmd_delay">
				<li>
					<span class="key">Cmd Delay: </span>
					<span class="value">
						<xsl:value-of  select="@cmd_delay" />
					</span>
				</li>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="ma:Profile">
				<li>
					<span class="key">Profile: </span>
					<span class="value">
						<xsl:call-template name="AddressLinkFormatter"><xsl:with-param name="addressLink" select="ma:Profile"/></xsl:call-template>
					</span>
				</li>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="ma:Info">
				<li>
					<span class="key">Info: </span>
					<span class="value">
						<xsl:value-of  select="ma:Info" />
					</span>
				</li>
			</xsl:when>
		</xsl:choose>
	</ul>

	<xsl:call-template name="CueDatas">
		<xsl:with-param name="value_multipart_index" select="@index"/>
		<xsl:with-param name="effect_multipart_index" select="@index"/>
	</xsl:call-template>
</xsl:template>

 <xsl:template name="CueDatas" >
	<xsl:param name="value_multipart_index" />
	<xsl:param name="effect_multipart_index" />
	<table class="CueDatas">
		<tr>
			<th>Channel</th>
			<th>Value</th>
			<th>Fade</th>
			<th>Delay</th>
			<th>Preset</th>
			<th>Effect</th>
			<th>Effect Flags</th>
			<th>Effect Rate</th>
			<th>Effect Low</th>
			<th>Effect Low Preset</th>
			<th>Effect High</th>
			<th>Effect High Preset</th>
			<th>Effect Phase</th>
			<th>Effect Width</th>
		</tr>
		<xsl:apply-templates select="./../ma:CueDatas/ma:CueData[@value_multipart_index=$value_multipart_index ] | ./../ma:CueDatas/ma:CueData[@effect_multipart_index=$effect_multipart_index ] ">
				<xsl:with-param name="value_multipart_index" select="$value_multipart_index "/>
				<xsl:with-param name="effect_multipart_index" select="$effect_multipart_index "/>
		</xsl:apply-templates>
	</table>
</xsl:template>

 <xsl:template match="ma:CueData" >
	<xsl:param name="value_multipart_index" />
	<xsl:param name="effect_multipart_index" />
	<tr>
		<xsl:call-template name="AlternatingTrClass">
			<xsl:with-param name="index" select="position()"/>
	   </xsl:call-template>
		<td class="colString"><xsl:call-template name="ChannelLinkFormatter"><xsl:with-param name="channelLink" select="ma:Channel"/></xsl:call-template></td>
		<xsl:choose>
			<xsl:when test="@value_multipart_index=$value_multipart_index ">
				<td class="colFloat"><xsl:call-template name="ValueFormatter"><xsl:with-param name="value" select="ma:Value"/></xsl:call-template></td>
				<td class="colTime"><xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="ma:Fade"/></xsl:call-template></td>
				<td class="colTime"><xsl:call-template name="TimeFormatter"><xsl:with-param name="time" select="ma:Delay"/></xsl:call-template></td>
				<td class="colString"><xsl:call-template name="AddressLinkFormatter"><xsl:with-param name="addressLink" select="ma:Preset"/></xsl:call-template></td>
			</xsl:when>
			<xsl:otherwise>
				<td></td><td></td><td></td><td></td>
			 </xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="@effect_multipart_index=$effect_multipart_index ">
				<td class="colString"><xsl:call-template name="AddressLinkFormatter"><xsl:with-param name="addressLink" select="ma:Effect"/></xsl:call-template></td>
				<td class="colString"><xsl:value-of  select="ma:EffectFlags" /></td>
				<td class="colFloat"><xsl:call-template name="ValueFormatter"><xsl:with-param name="value"  select="ma:EffectRate" /></xsl:call-template></td>
				<td class="colFloat"><xsl:call-template name="ValueFormatter"><xsl:with-param name="value"  select="ma:EffectValue1" /></xsl:call-template></td>
				<td class="colString"><xsl:call-template name="AddressLinkFormatter"><xsl:with-param name="addressLink" select="ma:EffectValue1Preset"/></xsl:call-template></td>
				<td class="colFloat"><xsl:call-template name="ValueFormatter"><xsl:with-param name="value"  select="ma:EffectValue2" /></xsl:call-template></td>
				<td class="colString"><xsl:call-template name="AddressLinkFormatter"><xsl:with-param name="addressLink" select="ma:EffectValue2Preset"/></xsl:call-template></td>
				<td class="colFloat"><xsl:call-template name="ValueFormatter"><xsl:with-param name="value"  select="ma:EffectPhase" /></xsl:call-template></td>
				<td class="colFloat"><xsl:call-template name="ValueFormatter"><xsl:with-param name="value"  select="ma:EffectWidth" /></xsl:call-template></td>
			</xsl:when>
			<xsl:otherwise>
				<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
			</xsl:otherwise>
		</xsl:choose>
	</tr>
</xsl:template>

<xsl:template name="ValueFormatter">
	<xsl:param name="value" />
	<xsl:choose>
		<xsl:when test="$value='-1.#QO'">
			(0)
		</xsl:when>
		<xsl:when test="$value='NaN'">
			(R)
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="contains($value,'e')">
					0
				</xsl:when>
				<xsl:when test="number($value)&gt;'-10000'">
					<xsl:value-of select="round($value*10) div 10"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$value"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

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

<xsl:template name="CueNumberFormatter">
	<xsl:param name="cueNumber" />
	<xsl:value-of  select="$cueNumber/@number" />
	<xsl:if test="$cueNumber/@sub_number &gt; 0"><xsl:value-of  select="format-number($cueNumber/@sub_number div 1000,'.###')" /></xsl:if>
</xsl:template>

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

</xsl:stylesheet>

