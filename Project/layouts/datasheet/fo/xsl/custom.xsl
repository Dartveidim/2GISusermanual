<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <xsl:attribute-set name="flierPage">
        <xsl:attribute name="page-width">210mm</xsl:attribute>
        <xsl:attribute name="page-height">297mm</xsl:attribute>
        <xsl:attribute name="margin-top">15mm</xsl:attribute>
        <xsl:attribute name="margin-right">15mm</xsl:attribute>
        <xsl:attribute name="margin-bottom">15mm</xsl:attribute>
        <xsl:attribute name="margin-left">15mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="flierTitle">
        <xsl:attribute name="margin-bottom">32pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="font-family">Sans</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-size">32pt</xsl:attribute>
        <xsl:attribute name="color">#0055AA</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="flierPara">
        <xsl:attribute name="line-height">21pt</xsl:attribute>
        <xsl:attribute name="font-family">Sans</xsl:attribute>
        <xsl:attribute name="font-size">14pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="flierFig">
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="margin-top">5mm</xsl:attribute>
        <xsl:attribute name="margin-bottom">5mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="flierCell">
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="padding-top">5pt</xsl:attribute>
        <xsl:attribute name="font-family">Sans</xsl:attribute>
        <xsl:attribute name="font-size">14pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="flierRow">
        <xsl:attribute name="height">21pt</xsl:attribute>
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-color">#000000</xsl:attribute>
        <xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="flierTable">
        <xsl:attribute name="border-style">none</xsl:attribute>
    </xsl:attribute-set>


    <xsl:template name="layout_master_set">

        <fo:layout-master-set>

            <fo:simple-page-master master-name="A4.Flier.Regular" xsl:use-attribute-sets="flierPage">
                <fo:region-body/>
            </fo:simple-page-master>

            <fo:page-sequence-master master-name="A4.Flier">
                <fo:single-page-master-reference master-reference="A4.Flier.Regular"/>
            </fo:page-sequence-master>

        </fo:layout-master-set>

    </xsl:template>


    <xsl:template match="title" mode="break">

        <fo:block>
            <xsl:value-of select="substring-before(., ' ')"/>
        </fo:block>

        <fo:block>
            <xsl:value-of select="substring-after(., ' ')"/>
        </fo:block>

    </xsl:template>


    <xsl:template match="*[contains(@class, 'topic/topic')]/title | table/title"/>


    <xsl:template match="p">

        <fo:block xsl:use-attribute-sets="flierPara">
            <xsl:apply-templates select="node()"/>
        </fo:block>

    </xsl:template>


    <xsl:template match="fig">

        <fo:block xsl:use-attribute-sets="flierFig">
            <xsl:apply-imports/>
        </fo:block>

    </xsl:template>


    <xsl:template match="entry">

        <fo:table-cell>
            <fo:block xsl:use-attribute-sets="flierCell">
                <xsl:apply-templates/>
            </fo:block>
        </fo:table-cell>

    </xsl:template>


    <xsl:template match="thead"/>


    <xsl:template match="row">

        <fo:table-row xsl:use-attribute-sets="flierRow">
            <xsl:apply-templates/>
        </fo:table-row>

    </xsl:template>


    <xsl:template match="tgroup">

        <fo:table xsl:use-attribute-sets="flierTable">
            <xsl:apply-templates/>
        </fo:table>

    </xsl:template>


    <xsl:template match="*[contains(@class, 'topic/body')] | section">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="/">

        <fo:root>

            <xsl:call-template name="layout_master_set"/>

            <fo:page-sequence master-reference="A4.Flier">

                <fo:flow flow-name="xsl-region-body">

                    <fo:block xsl:use-attribute-sets="flierTitle">
                        <xsl:apply-templates select="//*[local-name() = 'map']/title" mode="break"/>
                    </fo:block>

                    <fo:block>
                        <xsl:apply-templates select="//*[contains(@class, 'topic/topic')]/*"/>
                    </fo:block>

                </fo:flow>

            </fo:page-sequence>

        </fo:root>

    </xsl:template>

</xsl:stylesheet>
