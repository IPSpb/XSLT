<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"
                encoding="UTF-8"
                indent="yes"
                doctype-system="about:legacy-compat"/>

    <xsl:template match="/">
        <html>
        <head>
            <title>Валидация параметров формы</title>
            <link rel="stylesheet" href="main.css" />
            <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" />
        </head>
        <body>
            <form class="form-horizontal" role="form">
                <xsl:apply-templates select="fields/field" mode="webforms"/>
            </form>
        </body>
        </html>
    </xsl:template>

    <xsl:template match="field" mode="webforms">
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <xsl:if test="properties/property[@name = 'id']">
                    <xsl:attribute name="for">
                        <xsl:value-of select="properties/property[@name = 'id']"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="@label" /><xsl:text>:</xsl:text>
            </label>
            <div class="col-sm-5">
                <xsl:apply-templates select="." mode="webforms_input_type" />
            </div>
        </div>
    </xsl:template>

    <xsl:template match="field" mode="webforms_input_type">
        <input type="text">
            <xsl:attribute name="class">
                <xsl:value-of select="'form-control'"/>
            </xsl:attribute>
            <xsl:apply-templates select="properties/property" mode="property"/>
        </input>
    </xsl:template>

    <xsl:template match="field[@type='number']" mode="webforms_input_type">
        <input type="number">
            <xsl:attribute name="class">
                <xsl:value-of select="'form-control'"/>
            </xsl:attribute>
            <xsl:apply-templates select="properties/property" mode="property"/>
        </input>
    </xsl:template>

    <xsl:template match="field[@type='hidden']" mode="webforms">
        <input type="hidden">
            <xsl:apply-templates select="properties/property" mode="property"/>
        </input>
    </xsl:template>

    <xsl:template match="field[@type='select']" mode="webforms_input_type">
        <select>
            <xsl:attribute name="class">
                <xsl:value-of select="'form-control'"/>
            </xsl:attribute>
            <xsl:apply-templates select="properties/property" mode="property"/>
            <xsl:apply-templates select="items/item" mode="option"/>
        </select>
    </xsl:template>

    <xsl:template match="field[@type='submit']" mode="webforms">
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-5">
                <input type="submit">
                    <xsl:attribute name="class">
                        <xsl:value-of select="'btn btn-default'"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="properties/property" mode="property"/>
                </input>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="item" mode="option">
        <option value="{@value}">
            <xsl:value-of select="."/>
        </option>
    </xsl:template>

    <xsl:template match="property" mode="property">
        <xsl:attribute name="{@name}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

</xsl:stylesheet>