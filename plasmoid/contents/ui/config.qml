import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.11

GridLayout {
    property string cfg_url: plasmoid.configuration.url
    
    columns: 2
    
    Label {
        text: qsTr("Stream URL:")
    }

    TextField {
        id: url
        text: cfg_url
        Layout.fillWidth: true
        
        onTextChanged: 
        {
            cfg_url = text
            console.log( cfg_url )
        }
    }
}
