<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ma="http://schemas.malighting.de/grandma2/xml/MA" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
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
				<title>Tracking Sheet</title>
				<link type="text/css" rel="stylesheet" href="styles/include/style.css" />
			</head>
			<body>
				<div id="divAll">
					<xsl:apply-templates/>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="ma:Sequ">
		<table class="CueDatas">
			<tr>
				<th>CueNum </th>
				<th>CuePart </th>

				<th>Cue </th>

				<th>Fixture#</th>
				<th>Channel#</th>
				<th>Attribute</th>
				<th>Value</th>
				<th>IFade</th>
				<th>IDelay</th>
				<th>Preset</th>
				<th>Eff ID</th>
				<th>Eff Flags</th>
				<th>Eff Rate[sec]</th>
				<th>Eff Low</th>
				<th>Eff Low Preset</th>
				<th>Eff High</th>
				<th>Eff High Preset</th>
				<th>Eff Phase</th>
				<th>Eff Width</th>
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

		<xsl:call-template name="CueDatas">
			<xsl:with-param name="value_multipart_index" select="@index"/>
			<xsl:with-param name="effect_multipart_index" select="@index"/>
		</xsl:call-template>
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
		<!--	<xsl:call-template name="AlternatingTrClass">
		<xsl:with-param name="index" select="position()"/>
	</xsl:call-template>
-->
		<tr>

			<td class="colString">
				<xsl:call-template name="CueNumberFormatter"><xsl:with-param name="cueNumber" select="../../ma:Number"/></xsl:call-template>		
			</td>
			<td>
				<xsl:value-of  select="../../ma:CuePart[@index=$value_multipart_index]/@index" />
			</td>
			<td class="colString">
				<xsl:value-of  select="../../ma:CuePart[@index=$value_multipart_index]/@name" />
			</td>


			<xsl:call-template name="ChannelLinkFormatter"><xsl:with-param name="channelLink" select="ma:Channel"/></xsl:call-template>

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
					<td class="colFloat"><xsl:call-template name="ValueFormatter"><xsl:with-param name="value"  select="ma:EffectLow" /></xsl:call-template></td>
					<td class="colString"><xsl:call-template name="AddressLinkFormatter"><xsl:with-param name="addressLink" select="ma:EffectLowPreset"/></xsl:call-template></td>
					<td class="colFloat"><xsl:call-template name="ValueFormatter"><xsl:with-param name="value"  select="ma:EffectHigh" /></xsl:call-template></td>
					<td class="colString"><xsl:call-template name="AddressLinkFormatter"><xsl:with-param name="addressLink" select="ma:EffectHighPreset"/></xsl:call-template></td>
					<td class="colFloat"><xsl:call-template name="ValueFormatter"><xsl:with-param name="value"  select="ma:EffectPhase" /></xsl:call-template></td>
					<td class="colFloat"><xsl:call-template name="ValueFormatter"><xsl:with-param name="value"  select="ma:EffectWidth" /></xsl:call-template></td>
				</xsl:when>
				<xsl:otherwise>
				<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>



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
	<xsl:template name="CueNumberFormatter">
		<xsl:param name="cueNumber" />
		<xsl:value-of  select="$cueNumber/@number" />
		<xsl:if test="$cueNumber/@sub_number &gt; 0">
			<xsl:value-of  select="format-number($cueNumber/@sub_number div 1000,'.###')" />
		</xsl:if>
	</xsl:template>

	<!-- *************************************************************************************************************************** -->
	<xsl:template name="ChannelLinkFormatter">
		<xsl:param name="channelLink" />
		<td class="colString">
			<xsl:choose>
		<xsl:when test="$channelLink/@fixture_id>0"><xsl:value-of  select="$channelLink/@fixture_id" /></xsl:when>
			</xsl:choose>
		</td>
		<td class="colString">
			<xsl:choose>
		<xsl:when test="$channelLink/@channel_id>0"><xsl:value-of  select="$channelLink/@channel_id" /></xsl:when>
				<xsl:otherwise>-</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="$channelLink/@subfixture_id>0">
			.<xsl:value-of  select="$channelLink/@subfixture_id" />
				</xsl:when>
			</xsl:choose>
		</td>
		<td class="colString">
			<xsl:text> </xsl:text>
			<xsl:value-of  select="$channelLink/@attribute_name" />
		</td>
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

</xsl:stylesheet>

