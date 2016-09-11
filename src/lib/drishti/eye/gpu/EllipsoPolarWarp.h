/*!
  @file   EllipsoPolarWarp.h
  @author David Hirvonen
  @brief  Declaration of class for OpenGL ellipso-polar warping shader (via GL_TRIANGLE_STRIPS).

  \copyright Copyright 2014-2016 Elucideye, Inc. All rights reserved.
  \license{This project is released under the 3 Clause BSD License.}

*/

#ifndef ELLIPSO_POLAR_WARP_H
#define ELLIPSO_POLAR_WARP_H

#include "drishti/eye/gpu/TriangleStripWarp.h"
#include "drishti/eye/gpu/EyeWarp.h"

#include <opencv2/core.hpp>

BEGIN_OGLES_GPGPU

class EllipsoPolarWarp : public TriangleStripWarp
{
public:

    using EyeDelegate = std::function<EyeWarp(void)>;

    EllipsoPolarWarp();
    virtual const char *getProcName()
    {
        return "EllipsoPolarWarp";
    }
    virtual int render(int position = 0);
    virtual void filterRenderSetCoords();

    void addEyeDelegate(EyeDelegate delegate)
    {
        m_eyeDelegate = delegate;
    }

protected:

    void renderIrises();
    void renderIris(const DRISHTI_EYE::EyeModel &eye);

    EyeDelegate m_eyeDelegate;
    EyeWarp m_eye;
};

END_OGLES_GPGPU

#endif // ELLIPSO_POLAR_WARP_H