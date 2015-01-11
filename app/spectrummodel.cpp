#include "spectrummodel.h"

#include "spectrum.h"

#include <QDebug>

SpectrumModel::SpectrumModel(QObject *parent) : QObject(parent),
    bars({0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
{
}

QVariantList SpectrumModel::getFrequencies() const
{
    return bars;
}

void SpectrumModel::spectrumChanged(qint64 position, qint64 length, const FrequencySpectrum &spectrum)
{
    Q_UNUSED(position);
    Q_UNUSED(length);
    for (auto element : spectrum)
    {
        if (element.frequency >= SpectrumLowFreq && element.frequency < SpectrumHighFreq) {
            // frequency should be <= 1000 Hz for this example, and we have
            // 10 bars

            const qreal bandWidth = (SpectrumHighFreq - SpectrumLowFreq) / bars.count();
            const int bar_index = (element.frequency - SpectrumLowFreq) / bandWidth;
            if (bar_index < 0 || bar_index >= 10)
                qFatal("Index out of range, frequency %g", element.frequency);
            bars[bar_index] = element.amplitude;
        }
    }
    emit frequenciesChanged();
}

