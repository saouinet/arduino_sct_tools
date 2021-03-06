/**
 * Copyright (c) 2016 by Lothar Wendehals.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.yakindu.sct.arduino.generator.cpp

import com.google.inject.Inject
import org.yakindu.sct.generator.c.IContentTemplate
import org.yakindu.sct.generator.c.IGenArtifactConfigurations
import org.yakindu.sct.model.sexec.ExecutionFlow
import org.yakindu.sct.model.sgen.GeneratorEntry

class AbstractTimerHeader implements IContentTemplate {

	@Inject extension Naming

	override content(ExecutionFlow it, GeneratorEntry entry, IGenArtifactConfigurations locations) '''
		«header»
		
		#ifndef «abstractTimer.h.define»
		#define «abstractTimer.h.define»
		
		#include <stdio.h>
		#include "«typesModule.h»"
		#include "«timerInterface.h»"
		#include "«statemachineInterface.h»"
		#include "«timedStatemachineInterface.h»"
		#include "«timeEvent.h»"
		#include "«hardwareConnector.h»"
		
		class «abstractTimer»: public «timerInterface» {
		
		public:
			/* period in milliseconds */
			«abstractTimer»(«statemachineInterface»* statemachine, «hardwareConnector»* hardware,
					unsigned short maxParallelTimeEvents, unsigned int period);
		
			virtual ~«abstractTimer»();
		
			void start();
		
			void setTimer(«timedStatemachineInterface»* timedStatemachine, sc_eventid eventId, sc_integer time,
					sc_boolean isPeriodic);
		
			void unsetTimer(«timedStatemachineInterface»* timedStatemachine, sc_eventid eventId);
		
			void runCycle();
		
			void cancel();
		
		protected:
			«statemachineInterface»* statemachine;
		
			«hardwareConnector»* hardware;
		
			unsigned int period;
		
			virtual void init() = 0;
		
			virtual void sleep() = 0;
		
			virtual void stop() = 0;
		
		private:
			unsigned short maxParallelTimeEvents;
		
			«timeEvent»* events;
		
			void raiseTimeEvents();
		};
		
		#endif /* «abstractTimer.h.define» */
	'''
	
}
