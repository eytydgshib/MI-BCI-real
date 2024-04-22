
function box_out = threeclass_probability_Matrix_Initialize(box_in)
	
    disp('Box settings are:')
	for i=1:size(box_in.settings,2)
		fprintf('\t%s : %s\n',box_in.settings(i).name, num2str(box_in.settings(i).value)); 
    end
    
    box_in.user_data.is_headerset = false;
    
    box_out = box_in;
   
end
    
    