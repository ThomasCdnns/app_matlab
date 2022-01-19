clc;
close all;

load('filtre.mat');
[occurrences, test] = occurrences_note('notesFlute.wav', h);
disp(occurrences + " occurences found over " + test + " tests.")
[occurrences, test] = occurrences_note('NotesPiano.wav', h);
disp(occurrences + " occurences found over " + test + " tests.")
[occurrences, test] = occurrences_note('AccordsPiano.wav', h);
disp(occurrences + " occurences found over " + test + " tests.")

function [occurrences, test] = occurrences_note(fichier, filtre)

		result1 = "Note SOL présente entre  %2.1f et  %2.1f s\n";
        disp("================================================")
        disp(fichier);
		[y, Fe] = audioread(fichier);
		[length, channels] = size(y);

		if (channels >= 2)				      
			y = mean(y,channels);
        end

		Te	= 1/Fe;

		D_FIR = 1;

		yFiltered = filter(filtre, D_FIR, y);   %Filtering Signal
       
		windowTimeFrame = 500e-3;				   
        stepTimeFrame = windowTimeFrame/2;

		sizeWindow = round(windowTimeFrame/Te);
		sizeStep = round(stepTimeFrame/Te);
		triggerValue = 0.2;					        
		test = 0;
		occurrences = 0;	
        noteStart = 0;
        
		for n1 = 1 : sizeStep : length - sizeWindow		 

			n2 = n1+sizeWindow-1;
			MeanPY = mean(y(n1:n2).^2)*1000;
			MeanPWindow = mean(yFiltered(n1:n2).^2)*1000; 
			if (MeanPWindow >= (MeanPY*triggerValue))
				if (noteStart == 0)
					noteStart = n1;                  
				end
			else
				if (noteStart > 0)               
					T1 = round(noteStart*Te,2);
					T2 = round(n1*Te,2);
					fprintf(result1, T1, T2)
					occurrences = occurrences+1;
					noteStart = 0;
				end
			end
            test = test+1;
		end
		if (noteStart > 0)
			T1 = round(noteStart*Te,2);		 % Valeurs temporelle indice de debut
			T2 = round(length *Te,2);    % Valeurs temporelle indice de fin
			fprintf(result1, T1, T2);  % Afficher le message de présences
			occurrences = occurrences+1;		 % Compter le nombre de présences
		end

		if (occurrences == 0)
			disp(["La note SOL n'est pas présente dans le fichier ", fichier]);
		end

		time = (0:length-1)*Te;
        duree = round(length*Te);

 		f = (0:length-1)*(Fe/length);

 		FFT_y = abs(fft(y));	
        FFT_yFiltered = abs(fft(yFiltered));

		Amax = max(y)*1.1;
        
		figure;

 		subplot(221);	
        plot(time,y);
 		title(fichier);
        xlabel('Temps (s)');
        ylabel('Amplitude (V)');
        xticks(0:duree);	
        ylim([-Amax Amax]);

        subplot(222);	
        plot(time,yFiltered);
 		title('Signal Filtré'); 
        xlabel('Temps (s)'); 
        ylabel('Amplitude (V)');
        xticks(0:duree);
        ylim([-Amax Amax]); 
        grid on;

 		subplot(223);	
        plot(f,FFT_y);
 		title('FFT avant filtrage');
        xlabel('Fréquence (Hz)'); 
        ylabel('|FFT y| - Magnitude');
        
		subplot(224);	
        plot(f,FFT_yFiltered);
 		title('FFT après filtrage');
        xlabel('Fréquence (Hz)');
        ylabel('|FFT yFiltered| - Magnitude');
end