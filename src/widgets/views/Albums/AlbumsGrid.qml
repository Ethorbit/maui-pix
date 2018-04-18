import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


GridView
{
    id: albumsGridRoot

    property int itemSize : iconSizes.huge
    property int itemSpacing: space.huge

    property string currentAlbum : ""

    signal albumClicked(int index)

    clip: true

    width: parent.width
    height: parent.height

    cellWidth: itemSize + itemSpacing
    cellHeight: itemSize + itemSpacing*2

    focus: true

    boundsBehavior: Flickable.StopAtBounds
    flickableDirection: Flickable.AutoFlickDirection
    snapMode: GridView.SnapToRow

    model: ListModel
    {
        id: gridModel

        ListElement{album: "Favs"}
        ListElement{album: "Recent"}
    }

    highlightMoveDuration: 0

    delegate: AlbumDelegate
    {
        id: delegate
        albumSize : itemSize
        width: cellWidth
        height: cellHeight
        Connections
        {
            target: delegate
            onClicked:
            {
                albumsGridRoot.currentIndex = index
                albumClicked(index)
            }
        }
    }

    ScrollBar.vertical: ScrollBar{ visible: true}

}
