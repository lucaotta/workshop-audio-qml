#ifndef SPECTRUMMODEL_H
#define SPECTRUMMODEL_H

#include <QObject>
#include <QVariantList>
#include "frequencyspectrum.h"

class SpectrumModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList frequencies READ getFrequencies NOTIFY frequenciesChanged)

public:
    explicit SpectrumModel(QObject *parent = 0);
    QVariantList getFrequencies() const;

public slots:
    void spectrumChanged(qint64 position, qint64 length, const FrequencySpectrum &spectrum);

signals:
    void frequenciesChanged();

private:
    QVariantList bars;
};

#endif // SPECTRUMMODEL_H
