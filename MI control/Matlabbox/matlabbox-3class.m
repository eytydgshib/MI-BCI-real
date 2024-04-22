
function box_out = threeclass_probability_Matrix_Uninitialize(box_in)
    disp('Uninitializing the box...')
   
	fclose(box_in.user_data.s);
    instrreset;
    box_out = box_in;
end
    