import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.11

GridLayout 
{
    property string cfg_url: plasmoid.configuration.url
    property bool cfg_autoPlay: plasmoid.configuration.autoPlay
    
    columns: 2
    
    
    Label 
    {
        text: qsTr("Stream URL:")
    }

    TextField 
    {
        id: url
        text: cfg_url
        Layout.fillWidth: true
        
        onTextChanged: 
        {
            cfg_url = text
        }
    }
    
    GroupBox
    {
        title: i18n( "Options" )
        Layout.fillWidth: true
        Layout.columnSpan: 2
        
        Column
        {
            CheckBox
            {
                text: i18n( "Start playing automatically" )
                checked: cfg_autoPlay
                
                onClicked:
                {
                    cfg_autoPlay = checked
                }
            }
        }
    }
    
    Label
    {
        // dummy label to make the layout work
        Layout.fillHeight: true
    }
}
