#ifndef PICINFOMODEL_H
#define PICINFOMODEL_H

#include <QObject>
#include <QAbstractListModel>

#ifdef STATIC_MAUIKIT
#include "mauilist.h"
#else
#include <MauiKit/mauilist.h>
#endif

#include <QFileInfo>

class ReverseGeoCoder;
class PicInfoModel : public MauiList
{
	Q_OBJECT
		Q_PROPERTY (QUrl url READ url WRITE setUrl NOTIFY urlChanged)
		Q_PROPERTY (QString fileName MEMBER m_fileName NOTIFY fileNameChanged CONSTANT)

public:
	enum ROLES
	{
		KEY,
		VALUE
	};
	explicit PicInfoModel(QObject *parent = nullptr);
	~PicInfoModel();

	QUrl url() const
	{
		return m_url;
	}

public slots:
	void setUrl(QUrl url)
	{
		if(!FMH::fileExists(url))
		{
			return;
		}

		if (m_url == url)
			return;

		m_url = url;
		emit urlChanged(m_url);
		QFileInfo file(m_url.toLocalFile ());
		m_fileName = file.fileName ();
		emit fileNameChanged();
		this->parse();
	}

private:
	QUrl m_url;
	QString m_fileName;
	FMH::MODEL_LIST m_data;
	ReverseGeoCoder* m_geoCoder;

	void parse();

signals:
	void urlChanged(QUrl url);
	void fileNameChanged();
	// MauiList interface
public:
	FMH::MODEL_LIST items() const override;
};

#endif // PICINFOMODEL_H
