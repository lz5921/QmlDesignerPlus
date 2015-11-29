/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.1
import QtQuick.Controls 1.0 as Controls
import QtQuick.Layouts 1.0

Rectangle {

    property bool roundLeft: false
    property bool roundRight: false


    radius: roundLeft || roundRight ? 1 : 0
    gradient: Gradient {
        GradientStop {color: '#555' ; position: 0}
        GradientStop {color: '#444' ; position: 1}
    }

    border.width: roundLeft || roundRight ? 1 : 0
    border.color: "#2e2e2e"

    Rectangle {
        anchors.fill: parent
        visible: roundLeft && !roundRight
        anchors.leftMargin: 10
        anchors.topMargin: 1
        anchors.bottomMargin: 1
        Component.onCompleted: {
            gradient = parent.gradient
        }
    }

    Rectangle {
        anchors.fill: parent
        visible: roundRight && !roundLeft
        anchors.rightMargin: 10
        anchors.topMargin: 1
        anchors.bottomMargin: 1
        Component.onCompleted: {
            gradient = parent.gradient
        }
    }

    Rectangle {
        color: "#2e2e2e"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        anchors.leftMargin: roundLeft ? 3 : 0
        anchors.rightMargin: roundRight ? 3 : 0
    }

    Rectangle {
        color: "#2e2e2e"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        anchors.leftMargin: roundLeft ? 2 : 0
        anchors.rightMargin: roundRight ? 2 : 0
    }

}
