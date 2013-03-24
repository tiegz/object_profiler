ruby*:::object-create
{
    /* FILE - LINE - CLASS */
    this->val = copyinstr(arg1);
    this->val = strjoin(this->val, ":");
    this->val = strjoin(this->val, lltostr(arg2));
    this->val = strjoin(this->val, ":");
    this->val = strjoin(this->val, copyinstr(arg0));
    @objs[this->val] = count(); 
}

dtrace:::END
{
	printf("\n-----\n");
	printa("%s=%@d\n", @objs);
}

