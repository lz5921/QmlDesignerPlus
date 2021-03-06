/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing
**
** This file is part of Qt Creator.
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company.  For licensing terms and
** conditions see http://www.qt.io/terms-conditions.  For further information
** use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file.  Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, The Qt Company gives you certain additional
** rights.  These rights are described in The Qt Company LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
****************************************************************************/

import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4 as Controls


Column {
    id: colorEditor

    width: parent.width - 8

    property color color

    property bool supportGradient: false

    property alias caption: label.text

    property variant backendValue

    property variant value: backendValue.value

    property alias gradientPropertyName: gradientLine.gradientPropertyName

    function isNotInGradientMode() {
         return (buttonRow.checkedIndex !== 1)
    }

    onValueChanged: {
        colorEditor.color = colorEditor.value
    }

    onBackendValueChanged: {
        colorEditor.color = colorEditor.value
    }

    Timer {
        id: colorEditorTimer
        repeat: false
        interval: 100
        running: false
        onTriggered: {
            if (backendValue !== undefined)
                backendValue.value = colorEditor.color
        }
    }

    onColorChanged: {
        if (!gradientLine.isInValidState)
            return;

        if (supportGradient && gradientLine.hasGradient) {
            textField.text = convertColorToString(color)
            gradientLine.currentColor = color
        }

        if (isNotInGradientMode()) {
            //Delay setting the color to keep ui responsive
            colorEditorTimer.restart()
        }
    }

    GradientLine {
        property bool isInValidState: false
        visible: buttonRow.checkedIndex === 1
        id: gradientLine

        width: parent.width

        onCurrentColorChanged: {
            if (supportGradient && gradientLine.hasGradient)
                colorEditor.color = gradientLine.currentColor
        }

        onHasGradientChanged: {
             if (!supportGradient)
                 return

            if (gradientLine.hasGradient) {
                buttonRow.initalChecked = 1
                colorEditor.color = gradientLine.currentColor
            } else {
                buttonRow.initalChecked = 0
                colorEditor.color = colorEditor.value
            }
            buttonRow.checkedIndex = buttonRow.initalChecked
        }

        Connections {
            target: modelNodeBackend
            onSelectionToBeChanged: {
                colorEditorTimer.stop()
                gradientLine.isInValidState = false
            }
        }

        Connections {
            target: modelNodeBackend
            onSelectionChanged: {
                if (supportGradient && gradientLine.hasGradient) {
                    colorEditor.color = gradientLine.currentColor
                    gradientLine.currentColor = color
                }
                gradientLine.isInValidState = true
            }
        }

    }

    SectionLayout {
        width: parent.width

        rows: 5

        Item {
            height: 0
            width: 2
        }

        Item {
            height: 0
            width: 2
        }

        Label {
            id: label
            text: "Color"
        }

        SecondColumnLayout {

            LineEdit {
                id: textField

                writeValueManually: true

                validator: RegExpValidator {
                    regExp: /#[0-9A-Fa-f]{6}([0-9A-Fa-f]{2})?/g
                }

                showTranslateCheckBox: false

                backendValue: colorEditor.backendValue

                onAccepted: {
                    colorEditor.color = colorFromString(textField.text)
                }

                onCommitData: {
                    colorEditor.color = colorFromString(textField.text)
                    if (isNotInGradientMode())
                        backendValue.value = colorEditor.color
                }

                Layout.fillWidth: true
            }
            ColorCheckButton {
                id: checkButton
                color: colorEditor.color
            }

            ButtonRow {

                id: buttonRow
                exclusive: true

                ButtonRowButton {
                    iconSource: "images/icon_color_solid.png"
                    onClicked: {
                        colorEditor.backendValue.resetValue()
                        gradientLine.deleteGradient()
                    }
                    tooltip: qsTr("Solid Color")
                }
                ButtonRowButton {
                    visible: supportGradient
                    iconSource: "images/icon_color_gradient.png"
                    onClicked: {
                        colorEditor.backendValue.resetValue()
                        gradientLine.addGradient()
                    }

                    tooltip: qsTr("Gradient")
                }
                ButtonRowButton {
                    iconSource: "images/icon_color_none.png"
                    onClicked: {
                        colorEditor.color = "#00000000"
                        gradientLine.deleteGradient()
                    }
                    tooltip: qsTr("Transparent")
                }
            }

            ExpandingSpacer {
            }
        }

        ColorButton {
            property color bindedColor: colorEditor.color

            //prevent the binding to be deleted by assignment
            onBindedColorChanged: {
                colorButton.color = colorButton.bindedColor
            }

            enabled: buttonRow.checkedIndex !== 2
            opacity: checkButton.checked ? 1 : 0
            id: colorButton
            width: 116
            height: checkButton.checked ? 116 : 0

            Layout.preferredWidth: 116
            Layout.preferredHeight: checkButton.checked ? 116 : 0

            sliderMargins: Math.max(0, label.width - colorButton.width) + 4

            onClicked: colorEditor.color = colorButton.color
        }

        SecondColumnLayout {
        }

        Item {
            height: 4
            width :4
        }

    }
}
