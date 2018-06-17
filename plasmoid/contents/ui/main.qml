/*
 *   Copyright 2018 Andreas Blochberger <andreas@netts.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.0 as QtControls
import QtMultimedia 5.8

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.plasmoid 2.0 

PlasmaCore.IconItem 
{
    id: root
    
    property string url: plasmoid.configuration.url
    
    readonly property bool inPanel: (plasmoid.location === PlasmaCore.Types.TopEdge
        || plasmoid.location === PlasmaCore.Types.RightEdge
        || plasmoid.location === PlasmaCore.Types.BottomEdge
        || plasmoid.location === PlasmaCore.Types.LeftEdge)
    
    Layout.maximumWidth: inPanel ? units.iconSizeHints.panel : -1
    Layout.maximumHeight: inPanel ? units.iconSizeHints.panel : -1
    
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground    
    Plasmoid.onActivated: startStop()
    
    // source - the icon to be displayed
    source: isPlaying() ? "media-playback-stop" : "media-playback-start"

    MediaPlayer 
    {
        id: playMusic
        autoPlay: true
        source: root.url
        
        onStatusChanged:
        {
            if( playMusic.metaData.title != undefined )
            {
                toolTip.subText  = playMusic.metaData.title
                console.log( playMusic.metaData.title )
            }
                
            // console.log( "status changed " + status )
            switch( status )
            {
                case MediaPlayer.Loaded:
                    console.log( "Loaded" )
                    break
                case MediaPlayer.Buffered:
                    console.log( "Buffered" )
                    break
                case MediaPlayer.Loading:
                    console.log( "Loading" )
                    break
                case MediaPlayer.Buffering:
                    console.log( "Buffering" )
                    break
                case MediaPlayer.Stalled:
                    console.log( "Stalled" )
                    break
                case MediaPlayer.EndOfMedia:
                    console.log( "EndOfMedia" )
                    break
                case MediaPlayer.InvalidMedia:
                    console.log( "InvalidMedia" )
                    break
                case MediaPlayer.UnknownStatus:
                    console.log( "UnknownStatus" )
                    break
            }
        }
    }
	
	MouseArea
	{
        id: mouseArea
        anchors.fill: parent
        onClicked: startStop()
    }
    
    PlasmaCore.ToolTipArea {
        id: toolTip
        anchors.fill: parent
        mainText: i18n("Simple Radio Player")
        subText: (playMusic.metaData.title === undefined) ? i18n("Unknown") : playMusic.metaData.title
        icon: "radio"
    }    
    
    function startStop()
    { 
        if( isPlaying() )
            playMusic.stop()
        else
        {
            playMusic.source = root.url
            playMusic.play() 
        }
        
        root.source = isPlaying() ? "media-playback-stop" : "media-playback-start"        
    }

    function isPlaying()
    {
        return playMusic.playbackState == MediaPlayer.PlayingState
    }
    
    function onConfigChanged()
    {
        root.url = plasmoid.configuration.url
        console.log( "Config changed: " + root.url )
    }
}

