//
// Classroom License -- for classroom instructional use only.  Not for
// government, commercial, academic research, or other organizational use.
//
// File: ert_main.cpp
//
// Code generated for Simulink model 'SatelliteServicing_Mission'.
//
// Model version                  : 4.4
// Simulink Coder version         : 9.8 (R2022b) 13-May-2022
// C/C++ source code generated on : Mon May  1 12:51:07 2023
//
// Target selection: ert.tlc
// Embedded hardware selection: Intel->x86-64 (Windows64)
// Code generation objectives: Unspecified
// Validation result: Not run
//
#include <stdio.h>              // This example main program uses printf/fflush
#include "SatelliteServicing_Mission.h" // Model header file

static ExtU_SatelliteServicing_Missi_T SatelliteServicing_Mission_U;// External inputs 
static ExtY_SatelliteServicing_Missi_T SatelliteServicing_Mission_Y;// External outputs 
const char *RT_MEMORY_ALLOCATION_ERROR = "memory allocation error";
RT_MODEL_SatelliteServicing_M_T *SatelliteServicing_Mission_M;

//
// Associating rt_OneStep with a real-time clock or interrupt service routine
// is what makes the generated code "real-time".  The function rt_OneStep is
// always associated with the base rate of the model.  Subrates are managed
// by the base rate from inside the generated code.  Enabling/disabling
// interrupts and floating point context switches are target specific.  This
// example code indicates where these should take place relative to executing
// the generated code step function.  Overrun behavior should be tailored to
// your application needs.  This example simply sets an error status in the
// real-time model and returns from rt_OneStep.
//
void rt_OneStep(RT_MODEL_SatelliteServicing_M_T *const
                SatelliteServicing_Mission_M);
void rt_OneStep(RT_MODEL_SatelliteServicing_M_T *const
                SatelliteServicing_Mission_M)
{
  static boolean_T OverrunFlag{ false };

  // Disable interrupts here

  // Check for overrun
  if (OverrunFlag) {
    rtmSetErrorStatus(SatelliteServicing_Mission_M, "Overrun");
    return;
  }

  OverrunFlag = true;

  // Save FPU context here (if necessary)
  // Re-enable timer or interrupt here
  // Set model inputs here

  // Step the model
  SatelliteServicing_Mission_step(SatelliteServicing_Mission_M,
    &SatelliteServicing_Mission_U, &SatelliteServicing_Mission_Y);

  // Get model outputs here

  // Indicate task complete
  OverrunFlag = false;

  // Disable interrupts here
  // Restore FPU context here (if necessary)
  // Enable interrupts here
}

int_T sim_init(real_T* initial_conditions)
{
  // Allocate model data
  SatelliteServicing_Mission_M = SatelliteServicing_Mission
    (&SatelliteServicing_Mission_U, &SatelliteServicing_Mission_Y);
  if (SatelliteServicing_Mission_M == (nullptr)) {
    (void)fprintf(stderr, "Memory allocation error during model registration");
    return(1);
  }

  if (rtmGetErrorStatus(SatelliteServicing_Mission_M) != (nullptr)) {
    (void)fprintf(stderr, "Error during model registration: %s\n",
                  rtmGetErrorStatus(SatelliteServicing_Mission_M));

    // Terminate model
    SatelliteServicing_Mission_terminate(SatelliteServicing_Mission_M);
    return(1);
  }

  // ADD INITIAL CONDITIONS HERE
  SatelliteServicing_Mission_P.RTP_AE61E748_PositionTargetValu = initial_conditions[0];
  SatelliteServicing_Mission_P.RTP_3768B6F2_PositionTargetValu = initial_conditions[1];
  SatelliteServicing_Mission_P.RTP_406F8664_PositionTargetValu = initial_conditions[2];


  // Initialize model
  SatelliteServicing_Mission_initialize(SatelliteServicing_Mission_M,
    &SatelliteServicing_Mission_U, &SatelliteServicing_Mission_Y);

  return(0);
}

//
// The example main function illustrates what is required by your
// application code to initialize, execute, and terminate the generated code.
// Attaching rt_OneStep to a real-time clock is target specific. This example
// illustrates how you do this relative to initializing the model.
//
//int_T main(int_T argc, const char *argv[])
int_T sim_wrapper(real_T stopTime, real_T* actions, real_T* observations, int_T* dones, real_T* simTime)
{

  // Unused arguments
  //(void)(argc);
  //(void)(argv);


  int agents = 3;

  // Set the inputs for the model
//  SatelliteServicing_Mission_U.control_type = 1;
  for (int i=0; i<agents; i++) {
      SatelliteServicing_Mission_U.ManipulatorActions[i] = actions[i];
  }

  // Simulating the model step behavior (in non real-time) to
  //   simulate model behavior at stop time.

  while ((rtmGetErrorStatus(SatelliteServicing_Mission_M) == (nullptr)) &&
         !rtmGetStopRequested(SatelliteServicing_Mission_M)) {
    rt_OneStep(SatelliteServicing_Mission_M);
  }

  // Collect observations
  for (int i=0; i<50; i++) {
       observations[i] = SatelliteServicing_Mission_Y.Observations[i];
  }

  double current_time = rtmGetT(SatelliteServicing_Mission_M);
  *simTime = current_time;
  if (int(*simTime*1e6) % int(100.0*1e6) == 0) {
      printf("Current Time: %6.3f\n",*simTime);
  }

  // Determine if simulation has reached its end time
  if (rtmGetT(SatelliteServicing_Mission_M) > stopTime) {
      rtmSetStopRequested(SatelliteServicing_Mission_M,1);
      printf("Terminating CPP simulation\n");
      dones[0] = 1;
      SatelliteServicing_Mission_terminate(SatelliteServicing_Mission_M);
  } else {
      dones[0] = 0;
  }

  // Terminate model
  SatelliteServicing_Mission_terminate(SatelliteServicing_Mission_M);
  return 0;
}

//
// File trailer for generated code.
//
// [EOF]
//
