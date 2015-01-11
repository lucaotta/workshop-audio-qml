include(../spectrum.pri)

TEMPLATE = app

TARGET = spectrum

QT       += multimedia quick

CONFIG += c++11

SOURCES  += main.cpp \
            engine.cpp \
            frequencyspectrum.cpp \
            spectrumanalyser.cpp \
            tonegenerator.cpp \
            utils.cpp \
            wavfile.cpp \
    spectrummodel.cpp

HEADERS  += engine.h \
            frequencyspectrum.h \
            spectrum.h \
            spectrumanalyser.h \
            tonegenerator.h \
            utils.h \
            wavfile.h \
    spectrummodel.h

fftreal_dir = ../3rdparty/fftreal

INCLUDEPATH += $${fftreal_dir}

# Dynamic linkage against FFTReal DLL
!contains(DEFINES, DISABLE_FFT) {
    macx {
        # Link to fftreal framework
        LIBS += -F$${fftreal_dir}
        LIBS += -framework fftreal
    } else {
        LIBS += -L..$${spectrum_build_dir}
        LIBS += -lfftreal
    }
}

target.path = $$[QT_INSTALL_EXAMPLES]/multimedia/spectrum
INSTALLS += target

# Deployment

DESTDIR = ..$${spectrum_build_dir}
macx {
    !contains(DEFINES, DISABLE_FFT) {
        # Relocate fftreal.framework into spectrum.app bundle
        framework_dir = ../spectrum.app/Contents/Frameworks
        framework_name = fftreal.framework/Versions/1/fftreal
        QMAKE_POST_LINK = \
            mkdir -p $${framework_dir} &&\
            rm -rf $${framework_dir}/fftreal.framework &&\
            cp -R $${fftreal_dir}/fftreal.framework $${framework_dir} &&\
            install_name_tool -id @executable_path/../Frameworks/$${framework_name} \
                                $${framework_dir}/$${framework_name} &&\
            install_name_tool -change $${framework_name} \
                                @executable_path/../Frameworks/$${framework_name} \
                                ../spectrum.app/Contents/MacOS/spectrum
    }
} else {
    linux-g++*: {
        # Provide relative path from application to fftreal library
        QMAKE_LFLAGS += -Wl,--rpath=\\\$\$ORIGIN
    }
}

RESOURCES += \
    spectrum.qrc
