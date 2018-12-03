import QtQuick 2.9
import QtQuick.Controls 2.2
import org.kde.mauikit 1.0 as Maui

import "../../../view_models"

//import CloudList 1.0
import FMList 1.0
import FMModel 1.0


PixGrid
{
    id: control
    headBarExit: false
    visible: true
    holder.emojiSize: iconSizes.huge
    holder.emoji: if(!_cloudList.contentReady)
                      "qrc:/assets/animat-rocket-color.gif"
                  else
                      "qrc:/assets/ElectricPlug.png"

    holder.isGif: !_cloudList.contentReady
    holder.isMask: false
    holder.title : if(!_cloudList.contentReady)
                       qsTr("Loading content!")
                    else
                       qsTr("Nothing here")

    holder.body: if(!_cloudList.contentReady)
                     qsTr("Almost ready!")
                 else
                    qsTr("Make sure you're online and your cloud account is working")

    grid.delegate: PixPic
    {
        id: delegate
        source: "file://"+encodeURIComponent(model.thumbnail)
        label: model.label
        picSize : control.itemSize
        picRadius : control.itemRadius
        fit: control.fitPreviews
        showLabel: control.showLabels
        height: control.grid.cellHeight * 0.9
        width: control.grid.cellWidth * 0.8

    }

    FMModel
    {
        id: _cloudModel
        list: _cloudList
    }

    FMList
    {
        id: _cloudList
        path: "Cloud/"+currentAccount
        filterType: FMList.IMAGE
    }

    grid.model: _cloudModel

    //    property alias list : _cloudList




    //    model.list: _cloudList
    //        CloudList
    //    {
    //id: _cloudList
    //    }

}
