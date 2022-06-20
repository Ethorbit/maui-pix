import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3

import org.mauikit.controls 1.3 as Maui
import org.maui.pix 1.0 as Pix

import "../../../view_models"

Maui.Page
{
    id: control

    Maui.Theme.inherit: false
    Maui.Theme.colorGroup: Maui.Theme.View

    flickable: _gridView.flickable

    headBar.visible: true
    headBar.forceCenterMiddleContent: false
    headBar.middleContent: Maui.SearchField
    {
        Layout.fillWidth: true
        Layout.maximumWidth: 500
        Layout.alignment: Qt.AlignCenter

        placeholderText: i18np("Filter %1 tag", "Filter %1 tags", _tagsList.count)
        onAccepted: _tagsModel.filter = text
        onCleared: _tagsModel.filter = ""
    }

    headBar.rightContent: ToolButton
    {
        icon.name : "list-add"
        onClicked: newTagDialog.open()
    }

    Maui.GridView
    {
        id: _gridView
        anchors.fill: parent
        model: Maui.BaseModel
        {
            id: _tagsModel
            recursiveFilteringEnabled: true
            sortCaseSensitivity: Qt.CaseInsensitive
            filterCaseSensitivity: Qt.CaseInsensitive

            list: Pix.TagsList
            {
                id: _tagsList
            }
        }

        itemSize: Math.min(200, Math.max(100, Math.floor(width* 0.3)))
        itemHeight: itemSize + Maui.Style.rowHeight

        holder.visible: _gridView.count === 0
        holder.emoji: i18n("qrc:/assets/add-image.svg")
        holder.title :i18n("No Tags!")
        holder.body: i18n("You can create new tags to organize your gallery")

        delegate: Item
        {
            height: GridView.view.cellHeight
            width: GridView.view.cellWidth

            Maui.GalleryRollItem
            {
                anchors.fill: parent
                anchors.margins: Maui.Handy.isMobile ? Maui.Style.space.tiny : Maui.Style.space.big

                imageWidth: 120
                imageHeight: 120
flat: true
                isCurrentItem: parent.GridView.isCurrentItem
                images: model.preview.split(",")

                label1.text: model.tag
                label2.text: model.adddate
                template.alignment: Qt.AlignLeft

                iconSource: model.icon

                onClicked:
                {
                    _gridView.currentIndex = index
                    if(Maui.Handy.singleClick)
                    {
                        populateGrid(model.tag)
                    }
                }

                onDoubleClicked:
                {
                    _gridView.currentIndex = index
                    if(!Maui.Handy.singleClick)
                    {
                        populateGrid(model.tag)
                    }
                }
            }
        }
    }
}


